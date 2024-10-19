library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.op_codes.all;


entity fit_logic is
  
  port (
    A, B    : in std_logic_vector(12 downto 0);
    RD      : in std_logic_vector(31 downto 0);
    ADD_IN  : in std_logic_vector(12 downto 0);
    OP_CODE : in std_logic_vector(5 downto 0);
    D       : out std_logic_vector(31 downto 0);
    ADD_OUT : out std_logic_vector(43 downto 0);
    CTRL    : out std_logic_vector(1 downto 0);
    WE      : out std_logic_vector(3 downto 0));

end fit_logic;

architecture beh of fit_logic is
  
signal add_pl_one : std_logic_vector(12 downto 0);
signal control : std_logic_vector(1 downto 0);


begin  -- beh

  add_pl_one<=A+B+4;

  control<=ADD_IN(1 downto 0);
  CTRL<=control;

 address_p: process (control, ADD_IN, add_pl_one)
 begin  -- process address_p
   for i in 0 to 3 loop

     if control="00" then
       ADD_OUT(10 downto 0)<=ADD_IN(12 downto 2);
       ADD_OUT(21 downto 11)<=ADD_IN(12 downto 2);
       ADD_OUT(32 downto 22)<=ADD_IN(12 downto 2);
       ADD_OUT(43 downto 33)<=ADD_IN(12 downto 2);
     elsif control="01" then
       ADD_OUT(10 downto 0)<=add_pl_one(12 downto 2);
       ADD_OUT(21 downto 11)<=ADD_IN(12 downto 2);
       ADD_OUT(32 downto 22)<=ADD_IN(12 downto 2);
       ADD_OUT(43 downto 33)<=ADD_IN(12 downto 2);
     elsif control="10" then
       ADD_OUT(10 downto 0)<=add_pl_one(12 downto 2);
       ADD_OUT(21 downto 11)<=add_pl_one(12 downto 2);
       ADD_OUT(32 downto 22)<=ADD_IN(12 downto 2);
       ADD_OUT(43 downto 33)<=ADD_IN(12 downto 2);
     else
       ADD_OUT(10 downto 0)<=add_pl_one(12 downto 2);
       ADD_OUT(21 downto 11)<=add_pl_one(12 downto 2);
       ADD_OUT(32 downto 22)<=add_pl_one(12 downto 2);
       ADD_OUT(43 downto 33)<=ADD_IN(12 downto 2);
     end if;
   end loop;  -- i
 end process address_p;

  d_in_p: process (control, RD)
  begin  -- process d_in_p

    if control="00" then
      D( 7 downto 0)<=RD(7 downto 0);
      D( 15 downto 8)<=RD(15 downto 8);
      D( 23 downto 16)<=RD(23 downto 16);
      D( 31 downto 24)<=RD(31 downto 24);
    elsif control="01" then
      D( 7 downto 0)<=RD(31 downto 24);
      D( 15 downto 8)<=RD(7 downto 0);
      D( 23 downto 16)<=RD(15 downto 8);
      D( 31 downto 24)<=RD(23 downto 16);
    elsif control="10" then
      D( 7 downto 0)<=RD(23 downto 16);
      D( 15 downto 8)<=RD(31 downto 24);
      D( 23 downto 16)<=RD(7 downto 0);
      D( 31 downto 24)<=RD(15 downto 8);
    elsif control="11" then
      D( 7 downto 0)<=RD(15 downto 8);
      D( 15 downto 8)<=RD(23 downto 16);
      D( 23 downto 16)<=RD(31 downto 24);
      D( 31 downto 24)<=RD(7 downto 0);
    end if;
  end process d_in_p;



we_p: process (control, OP_CODE)
begin  -- process ctrl_enc_p
WE<="0000";
if OP_CODE=OP_SB then
    WE(conv_integer(control))<='1';
elsif OP_CODE=OP_SH then
  WE(conv_integer(control))<='1';
  if control="11" then
    WE(0)<='1';
  else
    WE(conv_integer(control)+1)<='1';
  end if;
elsif OP_CODE=OP_SW then
  WE<="1111";
else
  WE<="0000";
end if;  
end process we_p;
  

end beh;
