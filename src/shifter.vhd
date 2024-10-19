library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_SIGNED.all;
library UNISIM;
use UNISIM.ALL;
use UNISIM.VComponents.all; 

entity shifter is

generic (
  n : integer := 32;  -- parallelism
  x : integer := 5);  -- max shift 2^5                   
 
port (D         : in std_logic_vector(n-1 downto 0); 
      S         : in std_logic_vector(x-1 downto 0);
      CTRL1     : in std_logic_vector((2**x)-2 downto 0);
      Q         : out std_logic_vector(n-1 downto 0)); 
end shifter; 
 
architecture structural of shifter is

type sig_matrix_0 is array (n-1 downto 0) of std_logic_vector(x downto 0);  -- array of internal signal
type sig_matrix_1 is array (n-1 downto 0) of std_logic_vector(x-1 downto 0);  -- array of internal signal
signal internal_signal_0 : sig_matrix_0;
signal internal_signal_1 : sig_matrix_1;

-- dedicated hardware for fast carry propagate
component MUXF5
   port (O : out STD_ULOGIC;
         I0 : in STD_ULOGIC;
         I1 : in STD_ULOGIC;
         S : in STD_ULOGIC);
end component;

attribute BOX_TYPE: string; 
attribute BOX_TYPE of MUXF5: component is "BLACK_BOX";

begin
 

MUXF5_r: for i in 0 to n-1 generate
	MUXF5_c: for j in 0 to x-1 generate
		MUXF5s : MUXF5
			port map (
			O  => internal_signal_0(i)(j+1),
			I0 => internal_signal_0(i)(j),
			I1 => internal_signal_1(i)(j),
			S  => S(j));
	end generate MUXF5_c;
end generate MUXF5_r;

int_sig_col: for j in x downto 0 generate
    int_sig_row: for i in n-(2**j)-1 downto 0 generate
			internal_signal_1(i+(2**j))(j) <= internal_signal_0(i)(j);
	 end generate int_sig_row;
end generate int_sig_col; 


int_sig_col_CTRL1: for j in 0 to x-1 generate
    int_sig_row_CTRL1: for i in 0 to (2**j)-1 generate
			internal_signal_1(i)(j) <= CTRL1((2**j)+i-1);
	 end generate int_sig_row_CTRL1;
end generate int_sig_col_CTRL1; 

in_sig: for i in n-1 downto 0 generate
    internal_signal_0(i)(0) <= D(i);
end generate in_sig;  

out_sig: for i in n-1 downto 0 generate
    Q(i) <= internal_signal_0(i)(x);
end generate out_sig;       

end structural; 


