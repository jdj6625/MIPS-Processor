----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2024 05:46:43 PM
-- Design Name: 
-- Module Name: fibonacchiTB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use std.env.stop;

entity fibonacchiTB is
    generic(
		N : integer := 32
	);
end entity fibonacchiTB;

architecture bench of fibonacchiTB is

    signal clk: STD_LOGIC := '0';
    signal rst_top: STD_LOGIC := '0';
    signal ALUResult_top: STD_LOGIC_VECTOR (31 downto 0);
    signal Result_top: STD_LOGIC_VECTOR (31 downto 0);

    signal result_non0 : STD_LOGIC_VECTOR (31 downto 0);

    --other constants
	constant CLK_PERIOD : time := 10 ns; --makes 100 MHz
		
begin
    -----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	MIPS_main_1 : entity work.processor
		 --generic map (
		 --	N => N
		 --)
		port map (
			clk_main   => clk,
			rst_top       => rst_top,
			ALUResult_top => ALUResult_top,
            Result_top    => Result_top
        
		);	
    ----------------------------------------------------------

    -----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
        clk <= '1';
		wait for CLK_PERIOD / 2;
        clk <= '0';
		wait for CLK_PERIOD / 2;
	end process CLK_GEN;

	stimulus_process : process
    begin
        -- Loop through all instructions
        for i in 0 to 20 loop
            wait until rising_edge(clk);
            wait until rising_edge(clk);
            wait until rising_edge(clk);
            wait until rising_edge(clk);
            wait until rising_edge(clk);
        end loop;

        -- Test complete
        assert false
		  report "Testbench Concluded."
		  severity note; -- sim time = 5 * 20ns * 7instr = 700ns
        wait;
  	end process;
end;