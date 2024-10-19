library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity Register_File is
  
  generic (
    n_reg      : integer := 32;         -- number of register
    add_len    : integer := 5;          -- log2 of n_reg
    n_bit_word : integer := 32);        -- number of bits per word

  port (
    WE                  : in std_logic;        -- write enable
    ADX_D               : in std_logic_vector(add_len-1 downto 0);  -- input write address
    D                   : in std_logic_vector(n_bit_word-1 downto 0);  -- input write data
    CLK, RST            : in std_logic;
    ADX_A, ADX_B        : in std_logic_vector(add_len-1 downto 0);   -- input read address
    A, B                : out std_logic_vector(n_bit_word-1 downto 0));  -- output read data

end Register_File;



architecture beh of Register_File is

  type reg_vec is array (0 to n_reg-1) of std_logic_vector(n_bit_word-1 downto 0);
  
  signal registers : reg_vec;           -- creo un array di segnali

begin -- beh

  --registers(0) <= (others => '0');
  
  read_process: process (ADX_A, ADX_B, registers)
  begin  -- process read_process
 
      A <= registers (conv_integer(ADX_A));
      B <= registers (conv_integer(ADX_B));
      
  end process read_process;

  write_process: process (CLK, RST)
  begin  -- process write_process
    if RST = '1' then                 -- asynchronous reset (active high)
      --for i in 1 to n_reg-1 loop
      --  registers(i) <= (others => '0');
      --end loop;  -- i
      registers <= ( others => (others => '0'));
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if WE = '1' then
        if ((conv_integer(ADX_D)) /= 0) then
          registers(conv_integer(ADX_D)) <= D;
        end if;
      end if;	
    end if;
  end process write_process;
  

end beh;



