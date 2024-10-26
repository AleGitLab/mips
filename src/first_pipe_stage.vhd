library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
library UNISIM;
use UNISIM.all;
use UNISIM.VComponents.all;

entity First_Pipe_Stage is
  
  port (
    PC          : in  std_logic_vector(31 downto 0);
    RS1         : in  std_logic_vector(31 downto 0);
    B_J_CTR     : in  std_logic_vector(1 downto 0);
    B_J_ADD     : in  std_logic_vector(31 downto 0);
    IR          : out std_logic_vector(31 downto 0);
    NEXT_PC     : out std_logic_vector(31 downto 0);
    CLK, RST    : in  std_logic);
    
end First_Pipe_Stage;

architecture structural of First_Pipe_Stage is
  
signal PC_plus_4 : std_logic_vector(31 downto 0);

-- Component Declaration for these design elements
-- should be placed after architecture statement but before begin keyword
-- For the following component declaration, enter RAMB16_S9_{S9 | S18 | S36},
-- RAMB16_S18_{S18 | S36}, or RAMB16_S36_S36
component RAMB16_S36_S36
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
   port (DOA : out STD_LOGIC_VECTOR (31 downto 0);
         DOB : out STD_LOGIC_VECTOR (31 downto 0);
         DOPA : out STD_LOGIC_VECTOR (3 downto 0);
         DOPB : out STD_LOGIC_VECTOR (3 downto 0);
         ADDRA : in STD_LOGIC_VECTOR (8 downto 0);
         ADDRB : in STD_LOGIC_VECTOR (8 downto 0);
         CLKA : in STD_ULOGIC;
         CLKB : in STD_ULOGIC;
         DIA : in STD_LOGIC_VECTOR (31 downto 0);
         DIB : in STD_LOGIC_VECTOR (31 downto 0);
         DIPA : in STD_LOGIC_VECTOR (3 downto 0);
         DIPB : in STD_LOGIC_VECTOR (3 downto 0);
         ENA: in STD_ULOGIC;
         ENB : in STD_ULOGIC;
         SSRA : in STD_ULOGIC;
         SSRB : in STD_ULOGIC;
         WEA : in STD_ULOGIC;
         WEB : in STD_ULOGIC);
end component;

attribute BOX_TYPE: string; 
attribute BOX_TYPE of RAMB16_S36_S36: component is "BLACK_BOX";

signal PC_D : std_logic_vector(31 downto 0);
  
begin  -- structural

  
-- Component Attribute Specification for design element
-- should be placed after architecture declaration
-- but before the begin keyword
-- Put attributes, if necessary
-- Component Instantiation for design element
-- Should be placed in architecture after the begin keyword
INSTANCE_RAMB16_S36_S36  : RAMB16_S36_S36
-- synthesis translate_off
generic map (
  INIT_00 => X"1420fff000000000000000002021000100000000000000002001fffd2003000c",
  INIT_01 => X"0000000000000000000000000000000000000000000000004c20000000000000",
  INIT_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_08 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_09 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_0A => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_0B => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_0C => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_0D => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_0E => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_0F => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_10 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_11 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_12 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_13 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_14 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_15 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_16 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_2D => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_2E => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_2F => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_30 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_31 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_32 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_33 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_34 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_35 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_36 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_37 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_38 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_39 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_3A => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_3B => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_3C => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_3D => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_3E => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_3F => X"0000000000000000000000000000000000000000000000000000000000000000",
  INIT_A => X"0",
  INIT_B => X"0",
  INITP_00 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INITP_01 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INITP_02 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INITP_05 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INITP_06 => X"0000000000000000000000000000000000000000000000000000000000000000",
  INITP_07 => X"0000000000000000000000000000000000000000000000000000000000000000",
  SRVAL_A => X"0",
  SRVAL_B => X"0",
  WRITE_MODE_A => "WRITE_FIRST", 
  WRITE_MODE_B => "WRITE_FIRST")
  
  -- synopsys translate_on

 port map (DOA => IR,
           ADDRA => PC(10 downto 2),
           ADDRB => (others=>'0'),
           CLKA => CLK,
           CLKB => '0',
           DIA => (others=>'0'),
           DIB => (others=>'0'),
           DIPA => (others=>'0'),
           DIPB => (others=>'0'),
           ENA => '1',
           ENB => '1',
           SSRA => '0',
           SSRB => '0',
           WEA => '0',                 -- read only memory
           WEB => '0'); 

PC_D_procss: process (CLK, RST)
begin  -- process PC_D_procss
  if RST = '1' then                     -- asynchronous reset (active hi)
    PC_D <= conv_std_logic_vector(-4, 32);
  elsif CLK'event and CLK = '1' then    -- rising clock edge
    PC_D <= PC;
  end if;
end process PC_D_procss;

PC_plus_4 <= PC_D + 4;

-- purpose: next program counter selection (jumps and branches control)
-- type   : combinational
-- inputs : RS1
-- outputs: NEXT_PC
MUX_NEXT_PC: process (RS1,B_J_CTR,PC_plus_4,B_J_ADD)
begin  -- process MUX_NEXT_PC
  
  if B_J_CTR = "00" or B_J_CTR = "11" then
    NEXT_PC <= PC_plus_4;
  elsif B_J_CTR = "01" then
    NEXT_PC <= B_J_ADD;
  else
    NEXT_PC <= RS1;
  end if;
  
end process MUX_NEXT_PC;


end structural;