library ieee;
use ieee.std_logic_1164.all;

entity Third_Pipe_Stage is
  port (
    A, B, RD, PC_PLUS_FOUR_IN   : in  std_logic_vector(31 downto 0);
    OP_CODE, FUNCTIONS          : in  std_logic_vector(5 downto 0);
    CTRL1, ADDSUB               : in  std_logic;
    ADD_RD_IN                   : in  std_logic_vector(4 downto 0);
    RESULT, D, PC_PLUS_FOUR_OUT : out std_logic_vector(31 downto 0);
    ADD_OUT                     : out std_logic_vector(43 downto 0);
    ADD_RD_OUT                  : out std_logic_vector(4 downto 0);
    CTRL                        : out std_logic_vector(1 downto 0);
    OVF                         : out std_logic;
    WE                          : out std_logic_vector(3 downto 0));
end Third_Pipe_Stage;


architecture struct of Third_Pipe_Stage is


  component ALU
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
  end component;

  component fit_logic
  port (
    A, B   : in std_logic_vector(12 downto 0);
	 RD     : in std_logic_vector(31 downto 0);
    ADD_IN : in std_logic_vector(12 downto 0);
    OP_CODE: in std_logic_vector(5 downto 0);
    D      : out std_logic_vector(31 downto 0);
    ADD_OUT: out std_logic_vector(43 downto 0);
    CTRL   : out std_logic_vector(1 downto 0);
    WE     : out std_logic_vector(3 downto 0));
  end component;

  signal int_RESULT : std_logic_vector(31 downto 0);
  
begin  -- struct

  ALU_INST : ALU
    generic map (
      n => 32,
      x => 5)
    port map (
      A         => A,
      B         => B,
      CTRL1     => CTRL1,
      OP_CODE   => OP_CODE,
      FUNCTIONS => FUNCTIONS,
      ADDSUB    => ADDSUB,
      RESULT    => int_RESULT,
      OVF       => OVF);

  FIT_LOGIC_INST : fit_logic
    port map (
      A       => A(12 downto 0),
      B       => B(12 downto 0),
      RD      => RD,
      ADD_IN  => int_RESULT(12 downto 0),
      OP_CODE => OP_CODE,
      D       => D,
      ADD_OUT => ADD_OUT,
      CTRL    => CTRL,
      WE      => WE);
      

RESULT <= int_RESULT;
PC_PLUS_FOUR_OUT <= PC_PLUS_FOuR_IN;
ADD_RD_OUT <= ADD_RD_IN; 

end struct;
