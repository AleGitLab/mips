library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.all;
use UNISIM.VComponents.all;

entity micro is
  
  port (
    CLK, RST : in std_logic;
    OUT_WORD : out std_logic_vector(31 downto 0));

end micro;


architecture struct of micro is

component First_Pipe_Stage
  port (
    PC          : in  std_logic_vector(31 downto 0);
    RS1         : in  std_logic_vector(31 downto 0);
    B_J_CTR     : in  std_logic_vector(1 downto 0);
    B_J_ADD     : in  std_logic_vector(31 downto 0);
    IR          : out std_logic_vector(31 downto 0);
    NEXT_PC     : out std_logic_vector(31 downto 0);
    CLK, RST    : in  std_logic);
end component;

component Second_Pipe_Stage
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
end component;

component Third_Pipe_Stage
  port (
    A, B, RD, PC_PLUS_FOUR_IN   : in  std_logic_vector(31 downto 0);
    OP_CODE, FUNCTIONS          : in  std_logic_vector(5 downto 0);
    CTRL1, ADDSUB               : in  std_logic;
    ADD_RD_IN                   : in  std_logic_vector(4 downto 0);
    RESULT, D, PC_PLUS_FOUR_OUT : out std_logic_vector(31 downto 0);
    ADD_OUT                     : out std_logic_vector(43 downto 0);
    ADD_RD_OUT                  : out std_logic_vector(4 downto 0);
    CTRL                        : out std_logic_vector(1 downto 0);
    OVF                         : out std_logic;
    WE                          : out std_logic_vector(3 downto 0));
end component;

component Fourth_Pipe_Stage
  port (
    OVF          : in  std_logic;
    OP_CODE      : in  std_logic_vector(5 downto 0);
    DI           : in  std_logic_vector(31 downto 0);
    ADDR         : in  std_logic_vector(43 downto 0);
    CTRL         : in  std_logic_vector(1 downto 0);  
    PC_PLUS_FOUR : in  std_logic_vector(31 downto 0);
    RESULT       : in  std_logic_vector(31 downto 0);
    ADD_RD_IN    : in  std_logic_vector(4 downto 0);
    WE_IN        : in  std_logic_vector(3 downto 0);
    CLK, RST     : in  std_logic;
    OUTPUT       : out std_logic_vector(31 downto 0);
    ADD_RD_OUT   : out std_logic_vector(4 downto 0);
    WE_OUT       : out std_logic);
end component;


signal RS1, B_J_ADD, IR_from_fs, IR_to_ss, DATA_WRITE, RD_from_ss, RD_to_ts, NEXT_PC_from_fs, NEXT_PC_to_ss, A_from_ss, B_from_ss, A_to_ts, B_to_ts , PC_PLUS_FOUR_from_ss, PC_PLUS_FOUR_to_ts, RESULT_from_ts, RESULT_to_fs, D, PC_PLUS_FOUR_OUT_from_ts, PC_PLUS_FOUR_OUT_to_fs: std_logic_vector(31 downto 0);

signal B_J_CTR: std_logic_vector(1 downto 0);

signal ADD_RD_WB_OUT_from_ss, ADD_RD_WB_OUT_to_ts, ADD_RD_WB_IN, ADD_RD_OUT_from_ts, ADD_RD_OUT_to_fs : std_logic_vector(4 downto 0);

signal ADD_OUT : std_logic_vector(43 downto 0);

signal CTRL_from_ts, CTRL_to_fs : std_logic_vector(1 downto 0);

signal OP_CODE_from_ss, OP_CODE_to_ts, OP_CODE_to_fs, FUNCTIONS_from_ss, FUNCTIONS_to_ts : std_logic_vector(5 downto 0);

signal WE_MEMORY : std_logic_vector(3 downto 0);

signal OVF_from_ts, OVF_to_fs, WE, CTRL1_from_ss, CTRL1_to_ts, ADDSUB_from_ss, ADDSUB_to_ts : std_logic;



begin  -- struct


  first_inst : First_Pipe_Stage
    port map (
      PC      => NEXT_PC_from_fs,
      RS1     => RS1,
      B_J_CTR => B_J_CTR,
      B_J_ADD => B_J_ADD,
      IR      => IR_from_fs,
      NEXT_PC => NEXT_PC_from_fs,
      CLK     => CLK,
      RST     => RST);

  second_inst : Second_Pipe_Stage
    port map (
      DATA_WRITE    => DATA_WRITE,
      WE            => WE,
      CLK           => CLK,
      RST           => RST,
      ADD_RD_WB_IN  => ADD_RD_WB_IN,
      ADD_RD_WB_OUT => ADD_RD_WB_OUT_from_ss,
      RD            => RD_from_ss,
      IR            => IR_to_ss,
      NEXT_PC       => NEXT_PC_to_ss,
      RS1           => RS1,
      B_J_ADD       => B_J_ADD,
      CTRL1         => CTRL1_from_ss,
      ADDSUB        => ADDSUB_from_ss,
      B_J_CTR       => B_J_CTR,
      A             => A_from_ss,
      B             => B_from_ss,
      OP_CODE       => OP_CODE_from_ss,
      FUNCTIONS     => FUNCTIONS_from_ss,
      PC_PLUS_FOUR  => PC_PLUS_FOUR_from_ss);

third_inst : Third_Pipe_Stage
  port map (
    A                => A_to_ts,
    B                => B_to_ts,
    RD               => RD_to_ts,
    PC_PLUS_FOUR_IN  => PC_PLUS_FOUR_to_ts,
    OP_CODE          => OP_CODE_to_ts,
    FUNCTIONS        => FUNCTIONS_to_ts,
    CTRL1            => CTRL1_to_ts,
    ADDSUB           => ADDSUB_to_ts,
    ADD_RD_IN        => ADD_RD_WB_OUT_to_ts,
    RESULT           => RESULT_from_ts,
    D                => D,
    PC_PLUS_FOUR_OUT => PC_PLUS_FOUR_OUT_from_ts,
    ADD_OUT          => ADD_OUT,
    ADD_RD_OUT       => ADD_RD_OUT_from_ts,
    CTRL             => CTRL_from_ts,
    OVF              => OVF_from_ts,
    WE               => WE_MEMORY);

  fourth_inst : Fourth_Pipe_Stage
    port map (
      OVF          => OVF_to_fs,
      OP_CODE      => OP_CODE_to_fs,
      DI           => D,
      ADDR         => ADD_OUT,
      CTRL         => CTRL_to_fs,
      PC_PLUS_FOUR => PC_PLUS_FOUR_OUT_to_fs,
      RESULT       => RESULT_to_fs,
      ADD_RD_IN    => ADD_RD_OUT_to_fs,
      WE_IN        => WE_MEMORY,
      CLK          => CLK,
      RST          => RST,
      OUTPUT       => DATA_WRITE,
      ADD_RD_OUT   => ADD_RD_WB_IN,
      WE_OUT       => WE);


  OUT_WORD<=DATA_WRITE;
  
  -- purpose: Instantiation of registers between first and second stage ,second and third and between second and first
  -- type   : sequential
  -- inputs : CLK, RST
  -- outputs: 
  pipes1: process (CLK, RST)
  begin  -- process pipes1
    if RST = '1' then               -- asynchronous reset (active hi)
      RD_to_ts <= (others => '0');
      IR_to_ss <= (others => '0');
      NEXT_PC_to_ss <= (others => '0');
      A_to_ts <= (others => '0');
      B_to_ts <= (others => '0');
      PC_PLUS_FOUR_to_ts <= (others => '0');
      ADD_RD_WB_OUT_to_ts <= (others => '0');
      OP_CODE_to_ts <= (others => '0');
      FUNCTIONS_to_ts <= (others => '0');
      CTRL1_to_ts <= '0';
      ADDSUB_to_ts  <= '0';
      CTRL_to_fs <= (others => '0');
      RESULT_to_fs <= (others => '0');
      PC_PLUS_FOUR_OUT_to_fs <= (others => '0');
      ADD_RD_OUT_to_fs <=  (others => '0');
      OVF_to_fs <= '0';
      OP_CODE_to_fs <= (others => '0');
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      RD_to_ts <= RD_from_ss;
      IR_to_ss <= IR_from_fs ;
      NEXT_PC_to_ss <= NEXT_PC_from_fs;
      A_to_ts <= A_from_ss;
      B_to_ts <= B_from_ss;
      PC_PLUS_FOUR_to_ts <= PC_PLUS_FOUR_from_ss;
      ADD_RD_WB_OUT_to_ts <= ADD_RD_WB_OUT_from_ss;
      OP_CODE_to_ts <= OP_CODE_from_ss;
      FUNCTIONS_to_ts <= FUNCTIONS_from_ss;
      CTRL1_to_ts <= CTRL1_from_ss;
      ADDSUB_to_ts  <= ADDSUB_from_ss;
      CTRL_to_fs <= CTRL_from_ts;
      RESULT_to_fs <= RESULT_from_ts;
      PC_PLUS_FOUR_OUT_to_fs <= PC_PLUS_FOUR_OUT_from_ts;
      ADD_RD_OUT_to_fs <= ADD_RD_OUT_from_ts;
      OVF_to_fs <= OVF_from_ts;
      OP_CODE_to_fs <= OP_CODE_to_ts;
    end if;
  end process pipes1;
  
    
  

end struct;
