library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
library UNISIM;
use UNISIM.all;
use UNISIM.VComponents.all;
use work.op_codes.all;
use work.functions.all;

  
entity Second_Pipe_Stage is

  port (
    DATA_WRITE    : in  std_logic_vector(31 downto 0);
    WE            : in  std_logic;
    CLK, RST      : in  std_logic;
    ADD_RD_WB_IN  : in  std_logic_vector(4 downto 0);   -- From MUX for WB
    ADD_RD_WB_OUT : out std_logic_vector(4 downto 0);   -- To MUX for WB
    RD            : out std_logic_vector(31 downto 0);  -- Value stored into register RD
    IR            : in  std_logic_vector(31 downto 0);
    NEXT_PC       : in  std_logic_vector(31 downto 0);
    RS1           : out std_logic_vector(31 downto 0);
    B_J_ADD       : out std_logic_vector(31 downto 0);
    CTRL1         : out std_logic;
    ADDSUB        : out std_logic;
    B_J_CTR       : out std_logic_vector(1 downto 0);
    A             : out std_logic_vector(31 downto 0);
    B             : out std_logic_vector(31 downto 0);
    OP_CODE       : out std_logic_vector(5 downto 0);
    FUNCTIONS     : out std_logic_vector(5 downto 0);
    PC_PLUS_FOUR  : out std_logic_vector(31 downto 0));
    
end Second_Pipe_Stage;

architecture structural of Second_Pipe_Stage is

signal int_imm, int_A, int_B, out_A, out_B: std_logic_vector(31 downto 0);


component Register_File

  generic (
    n_reg      : integer := 32;         -- number of register
    add_len    : integer := 5;          -- log2 of n_reg
    n_bit_word : integer := 32);        -- number of bits per word

  port (
    WE           : in std_logic;                                        -- write enable
    ADX_D        : in std_logic_vector(add_len-1 downto 0);             -- input write address
    D            : in std_logic_vector(n_bit_word-1 downto 0);          -- input write data
    CLK, RST     : in std_logic;
    ADX_A, ADX_B : in std_logic_vector(add_len-1 downto 0);             -- input read address
    A, B         : out std_logic_vector(n_bit_word-1 downto 0));        -- output read data
  
end component;


  
begin  -- structural

  RF_inst : Register_File
    generic map (
      n_reg      => 32,
      add_len    => 5,
      n_bit_word => 32)
    port map (
      WE    => WE,
      ADX_D => ADD_RD_WB_IN,
      D     => DATA_WRITE,
      CLK   => CLK,
      RST   => RST,
      ADX_A => IR(25 downto 21),
      ADX_B => IR(20 downto 16),
      A     => int_A,
      B     => int_B);
  
  -- purpose: combinational block for sign extension
  -- type   : combinational
  -- inputs : IR
  -- outputs: imm
  sign_ext: process (IR)
  begin  -- process sign_ext
    if IR(31 downto 26) = OP_J or IR(31 downto 26) = OP_JAL then
      int_imm(25 downto 0) <= IR(25 downto 0);
      int_imm(31 downto 26) <= (others => IR(25));
    else
      int_imm(15 downto 0) <= IR(15 downto 0);
      int_imm(31 downto 16) <= (others => IR(15));
    end if;
    
  end process sign_ext;    

  -- purpose: RD address signal generation for WB
  -- type   : combinational
  -- inputs : IR
  -- outputs: ADD_RD_WB_OUT, RD
  RD_WB_generation: process (IR, int_B)
  begin  -- process RD_signal_generation
    if IR(31 downto 26) = OP_R_TYPE_INSTR then
      ADD_RD_WB_OUT <= IR(15 downto 11);
      RD <= (others => '0');    
    else
      ADD_RD_WB_OUT <= IR(20 downto 16);
      RD <= int_B;
    end if;
  end process RD_WB_generation;

  -- purpose: CTRL1 signal generation for shifter in ALU
  -- type   : combinational
  -- inputs : IR
  -- outputs: CTRL1
  CTRL1_generation: process (IR, int_A)
  begin  -- process CTRL1_generation
    if  IR(31 downto 26)=OP_R_TYPE_INSTR and ( IR(5 downto 0)=F_SRAI or  IR(5 downto 0)=F_SRA ) then 
     CTRL1 <= int_A(31);
    else
     CTRL1 <= '0';
    end if;
  end process CTRL1_generation;
  
  -- purpose: B_J_CTR signal generation for branches and jumps
  -- type   : combinational
  -- inputs : IR, int_imm
  -- outputs: B_J_CTR
  B_J_CTR_generation: process (IR, int_A)
  begin  -- process B_J_CTR_generation
    if ((int_A = X"00000000") and IR(31 downto 26) = OP_BEQZ) or ((int_A /= X"00000000") and IR(31 downto 26) = OP_BNEZ) or IR(31 downto 26) = OP_J or IR(31 downto 26) = OP_JAL then
      B_J_CTR <= "01";
    elsif IR(31 downto 26) = OP_JR or IR(31 downto 26) = OP_JALR then
      B_J_CTR <= "10";
    else
      B_J_CTR <= "00";
    end if;
  end process B_J_CTR_generation;

  -- purpose: Select right operands from RS1, RS2, Immediate or SA
  -- type   : combinational
  -- inputs : IR
  -- outputs: A, B
  signal_operand_generation: process (IR, int_A, int_B, int_imm)
  begin  -- process signal_operand_generation
    if IR(31 downto 26)=OP_R_TYPE_INSTR then
      if IR(5 downto 0)=F_SLLI or IR(5 downto 0)=F_SLAI then
        out_B(31 downto 5) <= (others => '0');
        out_B(4 downto 0) <= IR(10 downto 6);
        out_A <= int_A;
        ADDSUB <= '0';
      elsif IR(5 downto 0)=F_SLL or IR(5 downto 0)=F_SLA then
        out_B(31 downto 5) <= (others => '0');
        out_B(4 downto 0) <= int_B(10 downto 6);
        out_A <= int_A;
        ADDSUB <= '0';
      elsif IR(5 downto 0)=F_SRLI or IR(5 downto 0)=F_SRAI then
        for i in 31 downto 0 loop
          out_A(i) <= int_A(31-i);
        end loop;  -- i
        out_B(31 downto 5) <= (others => '0');
        out_B(4 downto 0) <= IR(10 downto 6);
        ADDSUB <= '0';
      elsif IR(5 downto 0)=F_SRL or IR(5 downto 0)=F_SRA then
        for i in 31 downto 0 loop
          out_A(i) <= int_A(31-i);
        end loop;  -- i
        out_B(31 downto 5) <= (others => '0');
        out_B(4 downto 0) <= int_B(10 downto 6);
        ADDSUB <= '0';
      else
        out_B <= int_B;
        out_A <= int_A;
        if IR(5 downto 0)=F_SUB or IR(5 downto 0)=F_SUBU then
          ADDSUB <= '1';
        else
          ADDSUB <= '0';
        end if;
      end if;
    else
      if IR(31 downto 26)=OP_ADDI or IR(31 downto 26)=OP_ADDUI or IR(31 downto 26)=OP_LB or IR(31 downto 26)=OP_LH or IR(31 downto 26)=OP_LW or IR(31 downto 26)=OP_LBU or IR(31 downto 26)=OP_LHU or IR(31 downto 26)=OP_SB or IR(31 downto 26)=OP_SH or IR(31 downto 26)=OP_SW or IR(31 downto 26)=OP_ANDI or IR(31 downto 26)=OP_ORI or IR(31 downto 26)=OP_XORI then
        out_A <= int_A;
        out_B <= int_imm;
        ADDSUB <= '0';
      elsif IR(31 downto 26)=OP_SUBI or IR(31 downto 26)=OP_SUBUI then
        out_A <= int_A;
        out_B <= int_imm;
        ADDSUB <= '1';
      else
        out_A <= (others => '0');
        out_B <= (others => '0');
        ADDSUB <= '0';
      end if;
    end if;
  end process signal_operand_generation;

  
  A <= out_A;
  B <= out_B;
  FUNCTIONS <= IR(5 downto 0);
  OP_CODE <= IR(31 downto 26);
  B_J_ADD <= NEXT_PC + int_imm;
  PC_plus_four <= NEXT_PC;
  RS1 <= int_A;
  
end structural;
