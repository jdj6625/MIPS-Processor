----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 09:31:30 AM
-- Design Name: 
-- Module Name: memory_stage - Behavioral
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

entity memory_stage is
    port(
        clk         : in std_logic;
        rst         : in std_logic;
        RegWrite    : in std_logic;
        MemtoReg    : in std_logic;
        WriteReg    : in std_logic_vector(4 downto 0);
        MemWrite    : in std_logic;
        ALUResult   : in std_logic_vector(31 downto 0);
        WriteData   : in std_logic_vector(31 downto 0);
        Switches    : in std_logic_vector(15 downto 0);

        RegWriteOut     : out std_logic;
        MemtoRegOut     : out std_logic;
        WriteRegOut     : out std_logic_vector(4 downto 0);
        MemOut          : out std_logic_vector(31 downto 0);
        ALUResultOut    : out std_logic_vector(31 downto 0);
        ActiveDigit     : out std_logic_vector(3 downto 0);
        SevenSegDigit   : out std_logic_vector(6 downto 0)
    );
end memory_stage;

architecture Behavioral of memory_stage is
    signal seven_seg_data : std_logic_vector(15 downto 0);
begin
    data_memory_inst: entity work.data_memory
        port map (
            clk => clk,
            w_en => MemWrite, 
            addr => ALUResult(9 downto 0),  
            d_in => WriteData, 
            switches => Switches,  
            d_out => MemOut, 
            seven_seg => seven_seg_data 
        );

    seven_seg_controller_inst: entity work.SevenSegController
        port map (
            clk => clk,
            rst => rst,
            display_number => seven_seg_data,
            active_segment => ActiveDigit, 
            led_out => SevenSegDigit  
        );

    RegWriteOut <= RegWrite;
    MemtoRegOut <= MemtoReg;
    WriteRegOut <= WriteReg;
    ALUResultOut <= ALUResult;
    
end Behavioral;