library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.ALL;
use UNISIM.VComponents.all;
use work.op_codes.all;

entity mem_vec is
    port (
         DO             : out STD_LOGIC_VECTOR (31 downto 0);
         ADDR           : in STD_LOGIC_VECTOR (43 downto 0);
         CLK            : in STD_ULOGIC;
         WE             : in std_logic_vector(3 downto 0);
         DI             : in STD_LOGIC_VECTOR (31 downto 0);
         ctrl           : in std_logic_vector (1 downto 0);
         OP_CODE        : in std_logic_vector (5 downto 0);
         SSR            : in STD_ULOGIC);
end mem_vec;



architecture struct of mem_vec is

-- Component Declaration for these design elements
-- should be placed after architecture statement but before begin keyword
-- For the following component declaration, enter RAMB16_S9_S9

component RAMB16_S9_S9
-- synthesis translate_off
generic (
INIT_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_08 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_09 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_0A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_0B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_0C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_0D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_0E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_0F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_10 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_11 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_12 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_13 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_14 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_15 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_16 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_17 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_18 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_19 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_1A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_1B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_1C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_1D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_1E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_1F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_20 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_21 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_22 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_23 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_24 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_25 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_26 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_27 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_28 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_29 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_2A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_2B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_2C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_2D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_2E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_2F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_30 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_31 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_32 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_33 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_34 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_35 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_36 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_37 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_38 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_39 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_3A : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_3B : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_3C : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_3D : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_3E : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_3F : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INIT_A : bit_vector := X"0";
INIT_B : bit_vector := X"0";
INITP_00 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_01 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_02 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_03 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_04 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_05 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_06 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
INITP_07 : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
SRVAL_A : bit_vector := X"0";
SRVAL_B : bit_vector := X"0";
WRITE_MODE_A : string := "WRITE_FIRST";
WRITE_MODE_B : string := "WRITE_FIRST");
   -- synthesis translate_on
   port (DOA : out STD_LOGIC_VECTOR (7 downto 0);
         DOB : out STD_LOGIC_VECTOR (7 downto 0);
         DOPA : out STD_LOGIC_VECTOR (0 downto 0);
         DOPB : out STD_LOGIC_VECTOR (0 downto 0);
         ADDRA : in STD_LOGIC_VECTOR (10 downto 0);
         ADDRB : in STD_LOGIC_VECTOR (10 downto 0);
         CLKA : in STD_ULOGIC;
         CLKB : in STD_ULOGIC;
         DIA : in STD_LOGIC_VECTOR (7 downto 0);
         DIB : in STD_LOGIC_VECTOR (7 downto 0);
         DIPA : in STD_LOGIC_VECTOR (0 downto 0);
         DIPB : in STD_LOGIC_VECTOR (0 downto 0);
         ENA: in STD_ULOGIC;
         ENB : in STD_ULOGIC;
         SSRA : in STD_ULOGIC;
         SSRB : in STD_ULOGIC;
         WEA : in STD_ULOGIC;
         WEB : in STD_ULOGIC);
end component;

attribute BOX_TYPE: string; 
attribute BOX_TYPE of RAMB16_S9_S9: component is "BLACK_BOX";

signal dout_temp, D : std_logic_vector(31 downto 0);
constant vector_value : bit_vector := X"0000000000000000000000000000000000000000000000000000000000000000";
constant bit_value : bit_vector := X"0";
constant string_value : string := "WRITE_FIRST";

begin  -- struct


ram_vec: for i in 0 to 3 generate  
-- Component Attribute Specification for design element
-- should be placed after architecture declaration
-- but before the begin keyword
-- Put attributes, if necessary
-- Component Instantiation for design element
-- Should be placed in architecture after the begin keyword

--RAMB16_S9_S9 INSTANCE_NAME : RAMB16_S9_S9
INSTANCE_NAME : RAMB16_S9_S9

-- synthesis translate_off
generic map (
INIT_00 => vector_value,
INIT_01 => vector_value,
INIT_02 => vector_value,
INIT_03 => vector_value,
INIT_04 => vector_value,
INIT_05 => vector_value,
INIT_06 => vector_value,
INIT_07 => vector_value,
INIT_08 => vector_value,
INIT_09 => vector_value,
INIT_0A => vector_value,
INIT_0B => vector_value,
INIT_0C => vector_value,
INIT_0D => vector_value,
INIT_0E => vector_value,
INIT_0F => vector_value,
INIT_10 => vector_value,
INIT_11 => vector_value,
INIT_12 => vector_value,
INIT_13 => vector_value,
INIT_14 => vector_value,
INIT_15 => vector_value,
INIT_16 => vector_value,
INIT_17 => vector_value,
INIT_18 => vector_value,
INIT_19 => vector_value,
INIT_1A => vector_value,
INIT_1B => vector_value,
INIT_1C => vector_value,
INIT_1D => vector_value,
INIT_1E => vector_value,
INIT_1F => vector_value,
INIT_20 => vector_value,
INIT_21 => vector_value,
INIT_22 => vector_value,
INIT_23 => vector_value,  -- purpose: 
INIT_24 => vector_value,
INIT_25 => vector_value,
INIT_26 => vector_value,
INIT_27 => vector_value,
INIT_28 => vector_value,
INIT_29 => vector_value,
INIT_2A => vector_value,
INIT_2B => vector_value,
INIT_2C => vector_value,
INIT_2D => vector_value,
INIT_2E => vector_value,
INIT_2F => vector_value,
INIT_30 => vector_value,
INIT_31 => vector_value,
INIT_32 => vector_value,
INIT_33 => vector_value,
INIT_34 => vector_value,
INIT_35 => vector_value,
INIT_36 => vector_value,
INIT_37 => vector_value,
INIT_38 => vector_value,
INIT_39 => vector_value,
INIT_3A => vector_value,
INIT_3B => vector_value,
INIT_3C => vector_value,
INIT_3D => vector_value,
INIT_3E => vector_value,
INIT_3F => vector_value,      
INIT_A => bit_value,      
INIT_B => bit_value,
INITP_00 => vector_value,
INITP_01 => vector_value,
INITP_02 => vector_value,
INITP_03 => vector_value,
INITP_04 => vector_value,
INITP_05 => vector_value,
INITP_06 => vector_value,
INITP_07 => vector_value,
SRVAL_A => bit_value,
SRVAL_B => bit_value,
WRITE_MODE_A => string_value,
WRITE_MODE_B => string_value)
   -- synopsys translate_on
     port map (DOA => dout_temp( (i+1)*8-1 downto i*8 ),
               ADDRA => ADDR( (i+1)*11-1 downto i*11 ),
               ADDRB => (others=>'0'),
               CLKA => CLK,
               CLKB => '0',
               DIA => DI( (i+1)*8-1 downto i*8 ),
               DIB => (others=>'0'),
               DIPA => (others=>'0'),
               DIPB => (others=>'0'),
               ENA => '1',
               ENB => '0',
               SSRA => SSR,
               SSRB => '0',
               WEA => WE(i),
               WEB => '0');
end generate ram_vec;




reorder: process (ctrl, dout_temp)
    begin  -- process reorder
    if ctrl="00" then
      D( 7 downto 0)<= dout_temp(7 downto 0);
      D( 15 downto 8)<=dout_temp(15 downto 8);
      D( 23 downto 16)<=dout_temp(23 downto 16);
      D( 31 downto 24)<=dout_temp(31 downto 24);
    elsif ctrl="01" then
      D( 7 downto 0)<=dout_temp(15 downto 8);
      D( 15 downto 8)<=dout_temp(23 downto 16);
      D( 23 downto 16)<=dout_temp(31 downto 24);
      D( 31 downto 24)<=dout_temp(7 downto 0);
    elsif ctrl="10" then
      D( 7 downto 0)<=dout_temp(23 downto 16);
      D( 15 downto 8)<=dout_temp(31 downto 24);
      D( 23 downto 16)<=dout_temp(7 downto 0);
      D( 31 downto 24)<=dout_temp(15 downto 8);
    elsif ctrl="11" then
      D( 7 downto 0)<=dout_temp(31 downto 24);
      D( 15 downto 8)<=dout_temp(7 downto 0);
      D( 23 downto 16)<=dout_temp(15 downto 8);
      D( 31 downto 24)<=dout_temp(23 downto 16);
    end if;
end process reorder;

output_logic: process (D, OP_CODE)
begin  -- process output_logic
  if OP_CODE=OP_LB then
    -- sign extension
    for i in 8 to 31 loop
      DO(i)<=D(7);
    end loop;  -- i
    DO(7 downto 0)<=D(7 downto 0);
  elsif OP_CODE=OP_LH then
    for i in 16 to 31 loop
      DO(i)<=D(15);
    end loop;  -- i
    DO(15 downto 0)<=D(15 downto 0);
  elsif OP_CODE=OP_LBU then
    DO<=("000000000000000000000000" & D(7 downto 0));
  elsif OP_CODE=OP_LHU then
    DO<=("0000000000000000" & D(15 downto 0));
  else
    DO<=D;
  end if;
end process output_logic;
         
end struct;















