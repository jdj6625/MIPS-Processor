----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2024 09:58:22 AM
-- Design Name: 
-- Module Name: executeTB - Behavioral
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
use work.globals.all ;

entity executeTB is
end executeTB;

architecture Behavioral of executeTB is

    type test_case is record
        RegWrite : std_logic;
        MemtoReg : std_logic;
        MemWrite : std_logic;
        ALUControl : std_logic_vector(3 downto 0);
        ALUSrc : std_logic;
        RegDst : std_logic;
        RegSrcA : std_logic_vector(31 downto 0);
        RegSrcB : std_logic_vector(31 downto 0);
        RtDest : std_logic_vector(4 downto 0);
        RdDest : std_logic_vector(4 downto 0);
        SignImm : std_logic_vector(31 downto 0);
        RegWriteOut : std_logic;
        MemtoRegOut : std_logic;
        MemWriteOut : std_logic;
        ALUResult : std_logic_vector(31 downto 0);
        WriteData : std_logic_vector(31 downto 0);
        WriteReg : std_logic_vector(4 downto 0);
    end record;

    type testcase_array is array(natural range <>) of test_Case;
    constant testcases: testcase_array := (
        
        (RegWrite => '0', 
         MemtoReg => '1', 
         MemWrite => '0', 
         ALUControl => "1000",
         ALUSrc => '0',
         RegDst => '1', 
         RegSrcA => x"00000001", 
         RegSrcB => x"00000001", 
         RtDest => x"00100",
         RdDest => x"01000", 
         SignImm => x"FFFFFFFC", 
         RegWriteOut => '0', 
         MemtoRegOut => '1',
         MemWriteOut => '0', 
         ALUResult => x"00000001", 
         WriteData => x"00000001", 
         WriteReg => x"01000"),
         
        (RegWrite => '0', 
         MemtoReg => '1', 
         MemWrite => '0', 
         ALUControl => "1010",
         ALUSrc => '0',
         RegDst => '1', 
         RegSrcA => x"00000001", 
         RegSrcB => x"00000001", 
         RtDest => x"00100",
         RdDest => x"01000", 
         SignImm => x"FFFFFFFC", 
         RegWriteOut => '0', 
         MemtoRegOut => '1',
         MemWriteOut => '0', 
         ALUResult => x"00000001", 
         WriteData => x"00000001", 
         WriteReg => x"01000"),
         
         (RegWrite => '0', 
         MemtoReg => '1', 
         MemWrite => '0', 
         ALUControl => "1011",
         ALUSrc => '0',
         RegDst => '1', 
         RegSrcA => x"00000001", 
         RegSrcB => x"00000001", 
         RtDest => x"00100",
         RdDest => x"01000", 
         SignImm => x"FFFFFFFC", 
         RegWriteOut => '0', 
         MemtoRegOut => '1',
         MemWriteOut => '0', 
         ALUResult => x"00000000", 
         WriteData => x"00000000", 
         WriteReg => x"01000"),
         
        (RegWrite => '0', 
         MemtoReg => '1', 
         MemWrite => '0', 
         ALUControl => "1100",
         ALUSrc => '1',
         RegDst => '1', 
         RegSrcA => "00000001", 
         RegSrcB => x"00000001", 
         RtDest => x"00100",
         RdDest => x"01000", 
         SignImm => x"00000001", 
         RegWriteOut => '0', 
         MemtoRegOut => '1',
         MemWriteOut => '0', 
         ALUResult => x"00000002", 
         WriteData => x"00000002", 
         WriteReg => x"01000"),
         
         (RegWrite => '0', 
         MemtoReg => '1', 
         MemWrite => '0', 
         ALUControl => "1101",
         ALUSrc => '1',
         RegDst => '1', 
         RegSrcA => x"00000002", 
         RegSrcB => x"00000001", 
         RtDest => x"00100",
         RdDest => x"01000", 
         SignImm => x"00000001", 
         RegWriteOut => '0', 
         MemtoRegOut => '1',
         MemWriteOut => '0', 
         ALUResult => x"00000001", 
         WriteData => x"00000001", 
         WriteReg => x"01000"),
         
         (RegWrite => '0', 
         MemtoReg => '1', 
         MemWrite => '0', 
         ALUControl => "1110",
         ALUSrc => '1',
         RegDst => '1', 
         RegSrcA => x"00000002", 
         RegSrcB => x"00000001", 
         RtDest => x"00100",
         RdDest => x"01000", 
         SignImm => x"00000001", 
         RegWriteOut => '0', 
         MemtoRegOut => '1',
         MemWriteOut => '0', 
         ALUResult => x"00000001", 
         WriteData => x"00000001", 
         WriteReg => x"01000"),
         
         (RegWrite => '0', 
         MemtoReg => '1', 
         MemWrite => '0', 
         ALUControl => "0101",
         ALUSrc => '0',
         RegDst => '1', 
         RegSrcA => x"00000003", 
         RegSrcB => x"00000004", 
         RtDest => x"00100",
         RdDest => x"01000", 
         SignImm => x"FFFFFFFC", 
         RegWriteOut => '0', 
         MemtoRegOut => '1',
         MemWriteOut => '0', 
         ALUResult => x"00000007", 
         WriteData => x"00000007", 
         WriteReg => x"01000"),
         
         (RegWrite => '0', 
         MemtoReg => '1', 
         MemWrite => '0', 
         ALUControl => "0100",
         ALUSrc => '1',
         RegDst => '1', 
         RegSrcA => x"00000003", 
         RegSrcB => x"00000002", 
         RtDest => x"00100",
         RdDest => x"01000", 
         SignImm => x"FFFFFFFC", 
         RegWriteOut => '0', 
         MemtoRegOut => '1',
         MemWriteOut => '0', 
         ALUResult => x"00000001", 
         WriteData => x"00000001", 
         WriteReg => x"01000"),
         
         (RegWrite => '0', 
         MemtoReg => '1', 
         MemWrite => '0', 
         ALUControl => "0010",
         ALUSrc => '1',
         RegDst => '1', 
         RegSrcA => x"00000001", 
         RegSrcB => x"00000002", 
         RtDest => x"00100",
         RdDest => x"01000", 
         SignImm => x"FFFFFFFC", 
         RegWriteOut => '0', 
         MemtoRegOut => '1',
         MemWriteOut => '0', 
         ALUResult => x"00000002", 
         WriteData => x"00000002", 
         WriteReg => x"01000")
    );

    signal tb_RegWrite : std_logic;
    signal tb_MemtoReg : std_logic;
    signal tb_MemWrite : std_logic;
    signal tb_ALUControl : std_logic_vector(3 downto 0);
    signal tb_ALUSrc : std_logic;
    signal tb_RegDst : std_logic;
    signal tb_RegSrcA : std_logic_vector(31 downto 0);
    signal tb_RegSrcB : std_logic_vector(31 downto 0);
    signal tb_RtDest : std_logic_vector(4 downto 0);
    signal tb_RdDest : std_logic_vector(4 downto 0);
    signal tb_SignImm : std_logic_vector(31 downto 0);
    signal tb_RegWriteOut : std_logic;
    signal tb_MemtoRegOut : std_logic;
    signal tb_MemWriteOut : std_logic;
    signal tb_ALUResult : std_logic_vector(31 downto 0);
    signal tb_WriteData : std_logic_vector(31 downto 0);
    signal tb_WriteReg : std_logic_vector(4 downto 0);
    
    begin

        -- Instantiate the Unit Under Test (UUT)
uut: entity work.execute
port map (
    RegWrite => tb_RegWrite,
    MemtoReg => tb_MemtoReg,
    MemWrite => tb_MemWrite,
    ALUControl => tb_ALUControl,
    ALUSrc => tb_ALUSrc,
    RegDst => tb_RegDst,
    RegSrcA => tb_RegSrcA,
    RegSrcB => tb_RegSrcB,
    RtDest => tb_RtDest,
    RdDest => tb_RdDest,
    SignImm => tb_SignImm,
    RegWriteOut => tb_RegWriteOut,
    MemtoRegOut => tb_MemtoRegOut,
    MemWriteOut => tb_MemWriteOut,
    ALUResult => tb_ALUResult,
    WriteData => tb_WriteData,
    WriteReg => tb_WriteReg
);

-- Stimulus process
stim_proc: process
begin
for i in testcases'range loop

    tb_RegWrite <= testcases(i).RegWrite;
    tb_MemtoReg <= testcases(i).MemtoReg;
    tb_MemWrite <= testcases(i).MemWrite;
    tb_ALUControl <= testcases(i).ALUControl;
    tb_ALUSrc <= testcases(i).ALUSrc;
    tb_RegDst <= testcases(i).RegDst;
    tb_RegSrcA <= testcases(i).RegSrcA;
    tb_RegSrcB <= testcases(i).RegSrcB;
    tb_RtDest <= testcases(i).RtDest;
    tb_RdDest <= testcases(i).RdDest;
    tb_SignImm <= testcases(i).SignImm;
    wait for 10 ns;
    assert tb_RegWriteOut = testcases(i).RegWriteOut
        report "Test case " & integer'image(i) & " failed: RegWriteOut does not match expected value."
        severity error;
    assert tb_MemtoRegOut = testcases(i).MemtoRegOut
        report "Test case " & integer'image(i) & " failed: MemtoRegOut does not match expected value."
        severity error;
    assert tb_MemWriteOut = testcases(i).MemWriteOut
        report "Test case " & integer'image(i) & " failed: MemWriteOut does not match expected value."
        severity error;
    assert tb_ALUResult = testcases(i).ALUResult
        report "Test case " & integer'image(i) & " failed: ALUResult does not match expected value."
        severity error;
    assert tb_WriteData = testcases(i).WriteData
        report "Test case " & integer'image(i) & " failed: WriteData does not match expected value."
        severity error;
    assert tb_WriteReg = testcases(i).WriteReg
        report "Test case " & integer'image(i) & " failed: WriteReg does not match expected value."
        severity error;
    wait for 10 ns;
end loop;
report "All test cases passed."
    severity note;  
wait;
end process;
end Behavioral;