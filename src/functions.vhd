library ieee;
use ieee.std_logic_1164.all;


package functions is
constant F_ADD : std_logic_vector(5 downto 0) := "100000";
constant F_ADDU : std_logic_vector(5 downto 0) := "100001";
constant F_SUB : std_logic_vector(5 downto 0) := "100010";
constant F_SUBU : std_logic_vector(5 downto 0) := "100011";
constant F_AND : std_logic_vector(5 downto 0) := "100100";
constant F_OR : std_logic_vector(5 downto 0) := "100101";
constant F_XOR : std_logic_vector(5 downto 0) := "100110";


constant F_SLLI : std_logic_vector(5 downto 0) := "000000";
constant F_SLAI : std_logic_vector(5 downto 0) := "000001";
constant F_SRLI : std_logic_vector(5 downto 0) := "000010";
constant F_SRAI : std_logic_vector(5 downto 0) := "000011";
constant F_SLL : std_logic_vector(5 downto 0) := "000100";
constant F_SLA : std_logic_vector(5 downto 0) := "000101";
constant F_SRL : std_logic_vector(5 downto 0) := "000110";
constant F_SRA : std_logic_vector(5 downto 0) := "000111";

end functions;

package body functions is

end functions;
