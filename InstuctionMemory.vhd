----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2024 01:58:47 PM
-- Design Name: 
-- Module Name: InstuctionMemory - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstuctionMemory is
    port (
        addr : in STD_LOGIC_VECTOR (27 downto 0);
        d_out : out STD_LOGIC_VECTOR (31 downto 0)
    );
end InstuctionMemory;

architecture Behavioral of InstuctionMemory is
type memory_file is array (0 to 1023) of std_logic_vector (7 downto 0);
signal mem : memory_file := (x"11", x"00", x"00", x"00",
                             x"11", x"11", x"11", x"11",
                             x"22", x"22", x"22", x"22",
                             x"33", x"33", x"33", x"33",
                             x"44", x"44", x"44", x"44", 
                             x"80", x"60", x"40", x"20", 
                             x"10", x"10", x"10", x"10", 
                             others => x"00");
begin
    process (addr)    
    begin
        if (to_integer(unsigned(addr)) >= 0 and to_integer(unsigned(addr)) <= 1020) then
            d_out <= mem(to_integer(unsigned(addr))) & mem(to_integer(unsigned(addr)) + 1) 
            & mem(to_integer(unsigned(addr)) + 2) & mem(to_integer(unsigned(addr)) + 3);
        else
            d_out <= x"00000000";
        end if; 
    end process;
end Behavioral;
