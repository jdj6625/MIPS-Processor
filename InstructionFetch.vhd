----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2024 01:51:30 PM
-- Design Name: 
-- Module Name: InstructionFetch - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity InstructionFetch is
    port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        instruction : out STD_LOGIC_VECTOR (31 downto 0)
    );
end InstructionFetch;

architecture Behavioral of InstructionFetch is
signal PC : std_logic_vector (31 downto 0):=(others=>'0');
begin
Memory : entity work.InstructionMemory
    port map (
        addr => PC(27 downto 0),
        d_out => instruction
    );

    process (clk, rst)
    begin
        if rst = '1' then
            PC <= (others => '0');
        elsif clk'event and clk = '1' then
            PC <= PC + 4;
        end if;
    end process;

end Behavioral;

