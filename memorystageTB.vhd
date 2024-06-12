----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/04/2024 09:38:34 AM
-- Design Name: 
-- Module Name: memorystageTB - Behavioral
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

entity memory_stage_TB is
end entity;

architecture tb of memory_stage_TB is
    signal clk          : std_logic := '0';
    signal rst          : std_logic := '0';
    signal RegWrite     : std_logic;
    signal MemtoReg     : std_logic;
    signal WriteReg     : std_logic_vector(4 downto 0);
    signal MemWrite     : std_logic;
    signal ALUResult    : std_logic_vector(31 downto 0);
    signal WriteData    : std_logic_vector(31 downto 0);
    signal Switches     : std_logic_vector(15 downto 0);

    signal RegWriteOut      : std_logic;
    signal MemtoRegOut      : std_logic;
    signal WriteRegOut      : std_logic_vector(4 downto 0);
    signal MemOut           : std_logic_vector(31 downto 0);
    signal ALUResultOut     : std_logic_vector(31 downto 0);
    signal ActiveDigit      : std_logic_vector(3 downto 0);
    signal SevenSegDigit    : std_logic_vector(6 downto 0);

    type tests is record
        RegWrite    : std_logic;
        MemtoReg    : std_logic;
        WriteReg    : std_logic_vector(4 downto 0);
        MemWrite    : std_logic;
        ALUResult   : std_logic_vector(31 downto 0);
        WriteData   : std_logic_vector(31 downto 0);
        Switches    : std_logic_vector(15 downto 0);

        RegWriteOut     : std_logic;
        MemtoRegOut     : std_logic;
        WriteRegOut     : std_logic_vector(4 downto 0);
        MemOut          : std_logic_vector(31 downto 0);
        ALUResultOut    : std_logic_vector(31 downto 0);
    end record;

    type test_array is array(natural range <>) of tests;

    constant test_vector_array : test_array :=(
        (
            RegWrite => '1',
            MemtoReg => '0',
            WriteReg => "00001",
            MemWrite => '1',
            ALUResult => X"00000001",
            WriteData => X"00000001",
            Switches => "0000000000000001",
            RegWriteOut => '1',
            MemtoRegOut => '0',
            WriteRegOut => "00001",
            MemOut => X"00000000",
            ALUResultOut => X"00000001"
        ),
        (
            RegWrite => '0',
            MemtoReg => '1',
            WriteReg => "00011",
            MemWrite => '0',
            ALUResult => X"00000001",
            WriteData => X"00000000",
            Switches => "0000000000000001",
            RegWriteOut => '0',
            MemtoRegOut => '1',
            WriteRegOut => "00011",
            MemOut => X"00000001",
            ALUResultOut => X"00000001"
        ),
        (
            RegWrite => '1',
            MemtoReg => '1',
            WriteReg => "00000",
            MemWrite => '1',
            ALUResult => X"00000001",
            WriteData => X"00000002",
            Switches => "0000000000000010",
            RegWriteOut => '1',
            MemtoRegOut => '1',
            WriteRegOut => "00000",
            MemOut => X"00000001",
            ALUResultOut => X"00000001"
        ),
        (
            RegWrite => '0',
            MemtoReg => '0',
            WriteReg => "00000",
            MemWrite => '0',
            ALUResult => X"00000001",
            WriteData => X"00000000",
            Switches => "0000000000000010",
            RegWriteOut => '0',
            MemtoRegOut => '0',
            WriteRegOut => "00000",
            MemOut => X"00000002",
            ALUResultOut => X"00000001"
        ),
        (
            RegWrite => '1',
            MemtoReg => '0',
            WriteReg => "00000",
            MemWrite => '1',
            ALUResult => X"000003FE",
            WriteData => X"00000001",
            Switches => X"0003",
            RegWriteOut => '1',
            MemtoRegOut => '0',
            WriteRegOut => "00000",
            MemOut => X"00000003",
            ALUResultOut => X"000003FE"
        ),
        (
            RegWrite => '0',
            MemtoReg => '1',
            WriteReg => "00000",
            MemWrite => '0',
            ALUResult => X"000003FE",
            WriteData => X"00000001",
            Switches => X"0003",
            RegWriteOut => '0',
            MemtoRegOut => '1',
            WriteRegOut => "00000",
            MemOut => X"00000003",
            ALUResultOut => X"000003FE"
        ),
        (
            RegWrite => '1',
            MemtoReg => '0',
            WriteReg => "00000",
            MemWrite => '1',
            ALUResult => X"000003FF",
            WriteData => X"00000001",
            Switches => X"0000",
            RegWriteOut => '1',
            MemtoRegOut => '0',
            WriteRegOut => "00000",
            MemOut => X"00000003",
            ALUResultOut => X"000003FF"
        ),
        (
            RegWrite => '0',
            MemtoReg => '1',
            WriteReg => "00000",
            MemWrite => '0',
            ALUResult => X"000003FF",
            WriteData => X"00000001",
            Switches => X"0000",
            RegWriteOut => '0',
            MemtoRegOut => '1',
            WriteRegOut => "00000",
            MemOut => X"00000003",
            ALUResultOut => X"000003FF"
        )
    );

begin
    uut: entity work.memory_stage
        port map (
            clk => clk,
            rst => rst,
            RegWrite => RegWrite,
            MemtoReg => MemtoReg,
            WriteReg => WriteReg,
            MemWrite => MemWrite,
            ALUResult => ALUResult,
            WriteData => WriteData,
            Switches => Switches,
            RegWriteOut => RegWriteOut,
            MemtoRegOut => MemtoRegOut,
            WriteRegOut => WriteRegOut,
            MemOut => MemOut,
            ALUResultOut => ALUResultOut,
            ActiveDigit => ActiveDigit,
            SevenSegDigit => SevenSegDigit
        );

    -- Clock process
    clk_process : process
    begin
        wait for 20 ns;
        clk <= not clk;
    end process;

    -- Stimulus process
    stimulus_process : process
    begin
        for i in test_vector_array'range loop
            RegWrite <= test_vector_array(i).RegWrite;
            MemtoReg <= test_vector_array(i).MemtoReg;
            WriteReg <= test_vector_array(i).WriteReg;
            MemWrite <= test_vector_array(i).MemWrite;
            ALUResult <= test_vector_array(i).ALUResult;
            WriteData <= test_vector_array(i).WriteData;
            Switches <= test_vector_array(i).Switches;
            wait for 30 ns; 
            assert RegWriteOut = test_vector_array(i).RegWriteOut and
                   MemtoRegOut = test_vector_array(i).MemtoRegOut and
                   WriteRegOut = test_vector_array(i).WriteRegOut and
                   MemOut = test_vector_array(i).MemOut and
                   ALUResultOut = test_vector_array(i).ALUResultOut
                   report "Test " & integer'image(i) & " failed."
                   severity error;
            wait for 10 ns;
        end loop;

        assert false
		  report "Testbench Concluded."
		  severity note;
    end process; 

end architecture;
