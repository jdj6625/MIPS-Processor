----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/20/2024 11:14:25 PM
-- Design Name: 
-- Module Name: register_file - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_file is
    generic(
        constant BIT_WIDTH : INTEGER := 4;         -- #Bits per reg
        constant LOG_PORT_DEPTH : INTEGER := 4);   -- Log base 2 of #reg
        
    port (
        clk_n   : in STD_LOGIC;
        we      : in STD_LOGIC;
        ADDR1   : in STD_LOGIC_VECTOR(LOG_PORT_DEPTH-1 downto 0);
        ADDR2   : in STD_LOGIC_VECTOR(LOG_PORT_DEPTH-1 downto 0);
        ADDR3   : in STD_LOGIC_VECTOR(LOG_PORT_DEPTH-1 downto 0);
        wd      : in STD_LOGIC_VECTOR(BIT_WIDTH-1 downto 0);
        RD1     : out STD_LOGIC_VECTOR(BIT_WIDTH-1 downto 0);
        RD2     : out STD_LOGIC_VECTOR(BIT_WIDTH-1 downto 0));
        
end register_file;

architecture Behavioral of register_file is

    type array_reg_file is array (0 to 2**LOG_PORT_DEPTH-1) of STD_LOGIC_VECTOR(BIT_WIDTH-1 downto 0);
    signal reg_file : array_reg_file := (others => (others => '0'));
    
begin
    
    process(all) is
    begin
        if (clk_n'event and clk_n = '0') then
            if (we = '1' and unsigned(ADDR3) /= 0) then
                reg_file(to_integer(unsigned(ADDR3))) <= wd;
            end if;
        end if;
    end process;
    
    RD1 <= (others => '0') when unsigned(ADDR1) = 0 else reg_file(to_integer(unsigned(ADDR1)));
    RD2 <= (others => '0') when unsigned(ADDR2) = 0 else reg_file(to_integer(unsigned(ADDR2)));

end Behavioral;
