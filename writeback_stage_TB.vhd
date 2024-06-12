----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 10:25:11 AM
-- Design Name: 
-- Module Name: writeback_stage_TB - Behavioral
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

entity WriteBackTB is
end WriteBackTB;

architecture behavioral of WriteBackTB is
    signal WriteReg             : std_logic_vector(4 downto 0);
    signal RegWrite, MemtoReg   : std_logic;
    signal ALUResult, ReadData  : std_logic_vector(31 downto 0);
    signal Result               : std_logic_vector(31 downto 0);
    signal WriteRegOut          : std_logic_vector(4 downto 0);
    signal RegWriteOut          : std_logic;

    component writeback_stage is
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
    end component;

begin
    uut : writeback_stage port map (
        WriteReg => WriteReg,
        RegWrite => RegWrite,
        MemtoReg => MemtoReg,
        ALUResult => ALUResult,
        ReadData => ReadData,
        Result => Result,
        WriteRegOut => WriteRegOut,
        RegWriteOut => RegWriteOut
    );

    process
    begin
        WriteReg <= "00000"; wait for 20 ns;
        assert WriteRegOut = "00000"
            report "WriteRegOut FAILED"
            severity error;

        WriteReg <= "11111"; wait for 20 ns;
        assert WriteRegOut = "11111"
            report "WriteRegOut FAILED"
            severity error;

        RegWrite <= '0'; wait for 20 ns;
        assert RegWriteOut = '0'
            report "RegWriteOut FAILED"
            severity error;

        RegWrite <= '1'; wait for 20 ns;
        assert RegWriteOut = '1'
            report "RegWriteOut FAILED"
            severity error;

        MemtoReg <= '0';
        ALUResult <= X"00000000";
        ReadData <= X"FFFFFFFF"; wait for 20 ns;
        assert Result = X"00000000"
            report "Result FAILED with reg = 0"
            severity error;

        MemtoReg <= '1'; wait for 20 ns;
        assert Result = X"FFFFFFFF"
            report "Result FAILED with mem = FFFFFFFF"
            severity error;

        MemtoReg <= '0';
        ALUResult <= X"55555555";
        ReadData <= X"AAAAAAAA"; wait for 20 ns;
        assert Result = X"55555555"
            report "Result FAILED with reg = 55555555"
            severity error;

        MemtoReg <= '1'; wait for 20 ns;
        assert Result = X"AAAAAAAA"
            report "Result FAILED with mem = AAAAAAAA"
            severity error;

        assert false
		  report "Testbench Concluded."
		  severity note;
    end process;
end behavioral;
