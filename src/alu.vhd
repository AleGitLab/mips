library ieee;
-- library op_codes;
-- use op_codes.op_codes.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;
use work.op_codes.all;
use work.functions.all;


entity alu is
  
  generic (
    n : integer := 32;						-- parallelism
    x : integer := 5);                 

  port (
    A, B          : in  std_logic_vector(n-1 downto 0);
    CTRL1         : in  std_logic;
    OP_CODE       : in  std_logic_vector(5 downto 0);
    FUNCTIONS     : in  std_logic_vector(5 downto 0);
    ADDSUB        : in  std_logic;
    RESULT        : out std_logic_vector(n-1 downto 0);
    OVF           : out std_logic);

end alu;


architecture mixed of alu is


  
component add_sub
generic (
  n : integer := 32);  -- parallelism
 
port (A : in std_logic_vector(n-1 downto 0); 
      B : in std_logic_vector(n-1 downto 0);
      SUM : out std_logic_vector(n-1 downto 0);
      ovf : out std_logic;
      ADDSUB : in std_logic); 
end component;

component shifter

generic (
      n : integer := 32;  -- parallelism
      x : integer := 5);  -- max shift 2^5                   
 
port (D : in std_logic_vector(n-1 downto 0); 
      S : in std_logic_vector(x-1 downto 0);
      CTRL1 : in std_logic_vector((2**x)-2 downto 0);
      Q : out std_logic_vector(n-1 downto 0));
  
end component;

signal SUM : std_logic_vector(n-1 downto 0);
signal Q : std_logic_vector(n-1 downto 0);
signal temp_ovf : std_logic;
signal int_CTRL1 : std_logic_vector((2**x)-2 downto 0);

begin  -- mixed

int_CTRL1_gen: for i in (2**x)-2 downto 0 generate
  int_CTRL1(i) <= CTRL1;
end generate int_CTRL1_gen;

  add_s : add_sub
    generic map (
      n => n)
    port map (
      A      => A,
      B      => B,
      SUM    => SUM,
      OVF    => temp_ovf,
      ADDSUB => ADDSUB);

  shift_s : shifter
    generic map (
      n => 32,
      x => 5)
    port map (
      D     => A,
      S     => B(x-1 downto 0),
      CTRL1 => int_CTRL1,
      Q     => Q);
               
  intr_set_p: process (OP_CODE, FUNCTIONS, SUM, Q, A, B) 
  
  begin  -- process intr_set_p

    if OP_CODE=OP_R_TYPE_INSTR and (FUNCTIONS=F_SLLI or FUNCTIONS=F_SLAI or FUNCTIONS=F_SLL or FUNCTIONS=F_SLA) then
      RESULT<=Q;
    elsif OP_CODE=OP_R_TYPE_INSTR and (FUNCTIONS=F_SRLI or FUNCTIONS=F_SRL or FUNCTIONS=F_SRAI or FUNCTIONS=F_SRA) then
      for i in n-1 downto 0 loop
        RESULT(i) <= Q(n-1-i);
      end loop;  -- i
    elsif (OP_CODE=OP_R_TYPE_INSTR and FUNCTIONS=F_OR) or OP_CODE=OP_ORI then
      RESULT<=A or B;
    elsif (OP_CODE=OP_R_TYPE_INSTR and FUNCTIONS=F_AND) or OP_CODE=OP_ANDI then
      RESULT<=A and B;
    elsif (OP_CODE=OP_R_TYPE_INSTR and FUNCTIONS=F_XOR) or OP_CODE=OP_XORI then
      RESULT<=A xor B;
    else
      RESULT<=SUM;
    end if;
	
end process intr_set_p;


ovf_p : process (OP_CODE, FUNCTIONS, temp_ovf)

begin  -- process ovf_p
  if OP_CODE = OP_ADDI or OP_CODE = OP_SUBI or (OP_CODE = OP_R_TYPE_INSTR and (FUNCTIONS = F_ADD or FUNCTIONS = F_SUB)) then
    OVF <= temp_ovf;
  else
    OVF <= '0';
  end if;
end process ovf_p;


end mixed;
