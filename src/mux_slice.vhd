library ieee;
use ieee.std_logic_1164.all;
use work.op_codes.all;



entity mux_slice is
  port (
    OP_CODE             : in  std_logic_vector(5 downto 0);
    OVF                 : in  std_logic;
    PC_PLUS_FOUR        : in  std_logic_vector(31 downto 0);
    DO_MEM              : in  std_logic_vector(31 downto 0);
    RESULT              : in  std_logic_vector(31 downto 0);
    ADD_RD_IN           : in  std_logic_vector(4 downto 0);
    OUTPUT              : out std_logic_vector(31 downto 0);
    ADD_RD_OUT          : out std_logic_vector(4 downto 0);
    WE                  : out std_logic);
end mux_slice;


architecture beh of mux_slice is

begin  -- beh
  
mux_logic: process (PC_PLUS_FOUR, DO_MEM, RESULT, OP_CODE)
begin  -- process mux_logic
  if OP_CODE=OP_LB or OP_CODE=OP_LH or OP_CODE=OP_LW or OP_CODE=OP_LBU or OP_CODE=OP_LHU then
    OUTPUT<=DO_MEM;
  elsif OP_CODE=OP_JAL or OP_CODE=OP_JALR then
    OUTPUT<=PC_PLUS_FOUR;
  else
    OUTPUT<=RESULT;
  end if;
end process mux_logic;


we_logic: process (OP_CODE, OVF, ADD_RD_IN)
begin  -- process we_logic
  if OP_CODE = OP_SB or OP_CODE = OP_SH or OP_CODE = OP_SW  or OP_CODE = OP_BEQZ or OP_CODE = OP_BNEZ or OP_CODE = OP_JR or OP_CODE = OP_J then
    WE<='0';    
  else
    if ((OVF='0' and ADD_RD_IN /= "00000") or OP_CODE=OP_JALR or OP_CODE=OP_JAL) then
      WE<='1';
    else
      WE<='0';
    end if;
  end if;
end process we_logic;

add_logic: process (ADD_RD_IN, OP_CODE)
begin  -- process add_logic
  if OP_CODE=OP_JAL or OP_CODE=OP_JALR then
    ADD_RD_OUT<="11111";
  else
    ADD_RD_OUT<=ADD_RD_IN;
  end if;
end process add_logic;

end beh;
