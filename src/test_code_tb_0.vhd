--------------------------------------------------------------------------------
-- Copyright (c) 1995-2003 Xilinx, Inc.
-- All Right Reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 9.1.02i
--  \   \         Application : ISE
--  /   /         Filename : test_code.vhw
-- /___/   /\     Timestamp : Thu Jun 28 00:37:40 2007
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: 
--Design Name: test_code_tb_0
--Device: Xilinx
--

library UNISIM;
use UNISIM.all;
use UNISIM.VComponents.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE STD.TEXTIO.ALL;

ENTITY test_code_tb_0 IS
END test_code_tb_0;

ARCHITECTURE testbench_arch OF test_code_tb_0 IS
    FILE RESULTS: TEXT OPEN WRITE_MODE IS "results.txt";

    COMPONENT micro
        PORT (
            CLK : In std_logic;
            RST : In std_logic;
            OUT_WORD : Out std_logic_vector (31 DownTo 0)
        );
    END COMPONENT;

    SIGNAL CLK : std_logic := '0';
    SIGNAL RST : std_logic := '0';
    SIGNAL OUT_WORD : std_logic_vector (31 DownTo 0) := "00000000000000000000000000000000";

    constant PERIOD : time := 200 ns;
    constant DUTY_CYCLE : real := 0.5;
    constant OFFSET : time := 0 ns;

    BEGIN
        UUT : micro
        PORT MAP (
            CLK => CLK,
            RST => RST,
            OUT_WORD => OUT_WORD
        );

        PROCESS    -- clock process for CLK
        BEGIN
            WAIT for OFFSET;
            CLOCK_LOOP : LOOP
                CLK <= '0';
                WAIT FOR (PERIOD - (PERIOD * DUTY_CYCLE));
                CLK <= '1';
                WAIT FOR (PERIOD * DUTY_CYCLE);
            END LOOP CLOCK_LOOP;
        END PROCESS;

        PROCESS
            BEGIN
                -- -------------  Current Time:  285ns
                WAIT FOR 285 ns;
                RST <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  885ns
                WAIT FOR 600 ns;
                RST <= '0';
                -- -------------------------------------
                -- -------------  Current Time:  1285ns
                WAIT FOR 400 ns;
                RST <= '1';
                -- -------------------------------------
                -- -------------  Current Time:  2085ns
                WAIT FOR 800 ns;
                RST <= '0';
                -- -------------------------------------
                WAIT FOR 8115 ns;

            END PROCESS;

    END testbench_arch;

