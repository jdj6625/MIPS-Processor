----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 09:39:10 AM
-- Design Name: 
-- Module Name: writeback_stage - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity writeback_stage is
    port (
        WriteReg    : in std_logic_vector(4 downto 0);
        RegWrite    : in std_logic;
        MemtoReg    : in std_logic;
        ALUResult   : in std_logic_vector(31 downto 0);
        ReadData    : in std_logic_vector(31 downto 0);
        Result      : out std_logic_vector(31 downto 0);
        WriteRegOut : out std_logic_vector(4 downto 0);
        RegWriteOut : out std_logic
    );
end writeback_stage;

architecture behavioral of writeback_stage is
begin
    process(ReadData, MemtoReg, ALUResult)
    begin
        case MemtoReg is
            when '1' => Result <= ReadData;
            when others => Result <= ALUResult;
        end case;
    end process;

    WriteRegOut <= WriteReg;
    RegWriteOut <= RegWrite;
    
end Behavioral;

