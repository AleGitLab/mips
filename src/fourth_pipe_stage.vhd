library ieee;
use ieee.std_logic_1164.all;


entity Fourth_Pipe_Stage is
  
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

end Fourth_Pipe_Stage;

architecture struct of Fourth_Pipe_Stage is


  component mem_vec
    port (
      DO        : out STD_LOGIC_VECTOR (31 downto 0);
      ADDR      : in STD_LOGIC_VECTOR (43 downto 0);
      CLK       : in STD_ULOGIC;
      WE        : in std_logic_vector(3 downto 0);
      DI        : in STD_LOGIC_VECTOR (31 downto 0);
      ctrl      : in std_logic_vector (1 downto 0);
      OP_CODE   : in std_logic_vector (5 downto 0);
      SSR       : in STD_ULOGIC);
  end component;

  component mux_slice
    port (
      OP_CODE      : in  std_logic_vector(5 downto 0);
      OVF          : in  std_logic;
      PC_PLUS_FOUR : in  std_logic_vector(31 downto 0);
      DO_MEM       : in  std_logic_vector(31 downto 0);
      RESULT       : in  std_logic_vector(31 downto 0);
      ADD_RD_IN    : in  std_logic_vector(4 downto 0);
      OUTPUT       : out std_logic_vector(31 downto 0);
      ADD_RD_OUT   : out std_logic_vector(4 downto 0);
      WE           : out std_logic);
  end component;

  signal DO : std_logic_vector(31 downto 0);
  
begin  -- struct

  MEM_VEC_INST : mem_vec
    port map (
      DO      => DO,
      ADDR    => ADDR,
      CLK     => CLK,
      WE      => WE_IN,
      DI      => DI,
      CTRL    => CTRL,
      OP_CODE => OP_CODE,
      SSR     => RST);

  MUX_SLICE_INST : mux_slice
    port map (
      OP_CODE      => OP_CODE,
      OVF          => OVF,
      PC_PLUS_FOUR => PC_PLUS_FOUR,
      DO_MEM       => DO,
      RESULT       => RESULT,
      ADD_RD_IN    => ADD_RD_IN,
      OUTPUT       => OUTPUT,
      ADD_RD_OUT   => ADD_RD_OUT,
      WE           => WE_OUT);

  

end struct;
