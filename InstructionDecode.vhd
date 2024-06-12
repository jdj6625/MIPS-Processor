----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2024 12:17:31 AM
-- Design Name: 
-- Module Name: InstructionDecode - Behavioral
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

entity InstructionDecode is
    Port (
        clk : in std_logic;
        Instruction     : in std_logic_vector (31 downto 0);
        RegWriteAddr    : in std_logic_vector (4 downto 0);
        RegWriteData    : in std_logic_vector (31 downto 0);
        RegWriteEn      : in std_logic;
        RegWrite        : out std_logic;
        MemtoReg        : out std_logic;
        MemWrite        : out std_logic;
        ALUControl      : out std_logic_vector (3 downto 0);
        ALUSrc          : out std_logic;
        RegDst          : out std_logic;
        RD1             : out std_logic_vector (31 downto 0);
        RD2             : out std_logic_vector (31 downto 0);
        RtDest          : out std_logic_vector (4 downto 0);
        RdDest          : out std_logic_vector (4 downto 0);
        ImmOut          : out std_logic_vector (31 downto 0)
    );
end InstructionDecode;

architecture Behavioral of InstructionDecode is

    signal Opcode   : std_logic_vector (5 downto 0);
    signal Funct    : std_logic_vector (5 downto 0);
    signal Rs       : std_logic_vector (4 downto 0);
    signal Rt       : std_logic_vector (4 downto 0);
    signal Rd       : std_logic_vector (4 downto 0);
    signal Sh_amt   : std_logic_vector (4 downto 0);
    signal Imm      : std_logic_vector (15 downto 0);
    signal ExtImm   : std_logic_vector (31 downto 0);

begin
    Opcode <= Instruction(31 downto 26);
    Rs <= Instruction(25 downto 21);
    Rt <= Instruction(20 downto 16);
    Rd <= Instruction(15 downto 11);
    Sh_amt <= Instruction(10 downto 6);
    Funct <= Instruction(5 downto 0);
    Imm <= Instruction(15 downto 0);
    RtDest <= Rt;
    RdDest <= Rd;
    ImmOut <= ExtImm;

    ControlUnit : entity work.ControlUnit
        port map (
            opcode => Opcode,
            funct => Funct,
            RegWrite => RegWrite,
            MemtoReg => MemtoReg,
            MemWrite => MemWrite,
            ALUControl => ALUControl,
            ALUSrc => ALUSrc,
            RegDst => RegDst
        );

    RegisterFile : entity work.RegisterFile
        port map (
            clk_n => clk,
            we => RegWriteEn,
            addr1 => Rs,
            addr2 => Rt,
            addr3 => RegWriteAddr,
            wd => RegWriteData,
            rd1 => RD1,
            rd2 => RD2
        );

    SignExtend_proc : process(Imm) is begin
        case Imm(15) is
            when '0' => ExtImm <= "0000000000000000" & Imm;
            when '1' => ExtImm <= "1111111111111111" & Imm;
            when others => ExtImm <= "XXXXXXXXXXXXXXXX" & Imm;
        end case;
    end process;

end Behavioral;
