----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2024 09:25:46 AM
-- Design Name: 
-- Module Name: carrysavemultTB - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all ;

entity carrysavemult_tb is
end carrysavemult_tb;

architecture Behavioral of carrysavemult_tb is

    -- Component declaration for the unit under test (UUT)
    component carrysavemult
    port (
        a : in std_logic_vector((N/2)-1 downto 0);
        b : in std_logic_vector((N/2)-1 downto 0);
        product : out std_logic_vector(N-1 downto 0)
    );
    end component;

    signal a : std_logic_vector(15 downto 0) := (others => '0');
    signal b : std_logic_vector(15 downto 0) := (others => '0');
    signal product : std_logic_vector(31 downto 0);
    
    type test_Case is record
        in1 : std_logic_vector(15 downto 0);
        in2 : std_logic_vector(15 downto 0);
        result : std_logic_vector(31 downto 0);
    end record;
    
    type testcase_array is array(natural range <>) of test_Case;

    constant testcases: testcase_array := (
    (x"1111", x"1111", x"01234321"),
    (x"FFFF", x"FFFF", x"FFFE0001"),
    (x"1010", x"F0F0", x"0F1E0F00"),
    (x"00FF", x"00FF", x"0000FE01"),
    (x"0001", x"FFFF", x"0000FFFF"),
    (x"7FFF", x"0001", x"00007FFF"),
    (x"8000", x"8000", x"40000000"),
    (x"0000", x"8000", x"00000000"),
    (x"AAAA", x"5555", x"38E31C72")
);


begin

    uut: carrysavemult 
    port map (
        a => a,
        b => b,
        product => product
    );

    stim_proc: process
    begin
        for i in testcases'range loop
            a <= testcases(i).in1;
            b <= testcases(i).in2;
            wait for 10 ns;
            assert product = testcases(i).result report "Error: Wrong Result" severity error;
            wait for 10 ns;
        end loop;
        wait;
    end process;

end Behavioral;
