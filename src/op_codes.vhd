library ieee;
use ieee.std_logic_1164.all;


package op_codes is


constant OP_ADDI : std_logic_vector(5 downto 0) := "001000";
constant OP_ADDUI : std_logic_vector(5 downto 0) := "001001";
constant OP_SUBI : std_logic_vector(5 downto 0) := "001010";
constant OP_SUBUI : std_logic_vector(5 downto 0) := "001011";
constant OP_ANDI : std_logic_vector(5 downto 0) := "001100";
constant OP_ORI : std_logic_vector(5 downto 0) := "001101";
constant OP_XORI : std_logic_vector(5 downto 0) := "001110";

constant OP_R_TYPE_INSTR : std_logic_vector(5 downto 0) := "000000";

constant OP_LB : std_logic_vector(5 downto 0) := "100000";
constant OP_LH : std_logic_vector(5 downto 0) := "100001";
constant OP_LW : std_logic_vector(5 downto 0) := "100011";
constant OP_LBU : std_logic_vector(5 downto 0) := "100100";
constant OP_LHU : std_logic_vector(5 downto 0) := "100101";
constant OP_SB : std_logic_vector(5 downto 0) := "101000";
constant OP_SH : std_logic_vector(5 downto 0) := "101001";
constant OP_SW : std_logic_vector(5 downto 0) := "101011";

constant OP_BEQZ : std_logic_vector(5 downto 0) := "000100";
constant OP_BNEZ : std_logic_vector(5 downto 0) := "000101";
constant OP_JR   : std_logic_vector(5 downto 0) := "010010";  --"000110";
constant OP_JALR : std_logic_vector(5 downto 0) := "010011";  --"000111";
constant OP_J    : std_logic_vector(5 downto 0) := "000010";
constant OP_JAL  : std_logic_vector(5 downto 0) := "000011";

end op_codes;

package body op_codes is

end op_codes;
