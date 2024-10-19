library IEEE;
use IEEE.std_logic_1164.all;
library UNISIM;
use UNISIM.ALL;
use UNISIM.VComponents.all; 
 
entity add_sub is

generic (
  n : integer := 32);                   -- parallelism
 
port (A : in std_logic_vector(n-1 downto 0); 
      B : in std_logic_vector(n-1 downto 0);
      SUM : out std_logic_vector(n-1 downto 0);
      OVF : out std_logic;
      ADDSUB : in std_logic); 
end add_sub; 
 
architecture structural of add_sub is

signal sel_MUX : std_logic_vector(n-1 downto 0);        -- internal selection of carry propagate MUXs
signal sub_bits : std_logic_vector(n-1 downto 0);       -- bits of subtraction selection
signal carry_int : std_logic_vector(n downto 0);        -- internal carry propagate

-- dedicated hardware for fast carry propagate
component MUXCY
   port (O : out STD_ULOGIC;
         CI : in STD_ULOGIC;
         DI : in STD_ULOGIC;
         S : in STD_ULOGIC);
end component;

attribute BOX_TYPE: string; 
attribute BOX_TYPE of MUXCY: component is "BLACK_BOX";

begin

MUXs: for i in 0 to n-1 generate
    MUXCYs : MUXCY
      port map (
        O  => carry_int(i+1),
        CI => carry_int(i),
        DI => A(i),
        S  => sel_MUX(i));
end generate MUXs;

sub_bits_p: process (ADDSUB)
begin  -- process sub_bits_p
  if ADDSUB='1' then
    sub_bits<= (others=>'1');
    carry_int(0)<= '1';
  else
    sub_bits<= (others=>'0');
    carry_int(0)<= '0';
  end if;
end process sub_bits_p;



sel_MUX <= (A xor B xor sub_bits);
SUM <= carry_int(n-1 downto 0) xor sel_MUX(n-1 downto 0);

ovf <= carry_int(n) xor carry_int(n-1);


end structural; 
