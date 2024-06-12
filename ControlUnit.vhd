----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2024 11:41:00 PM
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit is
    port (
        Opcode      : in std_logic_vector (5 downto 0);
        Funct       : in std_logic_vector (5 downto 0);
        RegWrite    : out std_logic;
        MemtoReg    : out std_logic;
        MemWrite    : out std_logic;
        ALUControl  : out std_logic_vector (3 downto 0);
        ALUSrc      : out std_logic;
        RegDst      : out std_logic
    );
end ControlUnit;

architecture Behavioral of ControlUnit is

    signal sRegWrite    : std_logic;
    signal sMemtoReg    : std_logic;
    signal sMemWrite    : std_logic;
    signal sALUControl  : std_logic_vector (3 downto 0);
    signal sALUSrc      : std_logic;
    signal sRegDst      : std_logic;

    constant opADD      : std_logic_vector (5 downto 0) := "100000";
    constant opAND      : std_logic_vector (5 downto 0) := "100100";
    constant opMULTU    : std_logic_vector (5 downto 0) := "011001";
    constant opOR       : std_logic_vector (5 downto 0) := "100101";
    constant opSLL      : std_logic_vector (5 downto 0) := "000000";
    constant opSRA      : std_logic_vector (5 downto 0) := "000011";
    constant opSRL      : std_logic_vector (5 downto 0) := "000010";
    constant opSUB      : std_logic_vector (5 downto 0) := "100010";
    constant opXOR      : std_logic_vector (5 downto 0) := "100110";
    constant opADDI     : std_logic_vector (5 downto 0) := "001000";
    constant opANDI     : std_logic_vector (5 downto 0) := "001100";
    constant opORI      : std_logic_vector (5 downto 0) := "001101";
    constant opXORI     : std_logic_vector (5 downto 0) := "001110";
    constant opSW       : std_logic_vector (5 downto 0) := "101011";
    constant opLW       : std_logic_vector (5 downto 0) := "100011";

begin

    RegWrite_proc : process (Opcode, Funct) is begin
        case Opcode is
            when "000000" =>
                case Funct is
                    when opADD | opSUB | opAND | opOR | opMULTU | opSLL | opSRA | opSRL | opXOR =>
                        sRegWrite <= '1';
                    when others =>
                        sRegWrite <= '0';
                end case;
            when opADDI | opANDI | opORI | opXORI | opLW =>
                sRegWrite <= '1';
            when others =>
                sRegWrite <= '0';
        end case;
    end process RegWrite_proc;

    MemtoReg_proc : process (Opcode) is begin
        case Opcode is
            when opLW =>
                sMemtoReg <= '1';
            when others =>
                sMemtoReg <= '0';
        end case;
    end process MemtoReg_proc;
    
    MemWrite_proc : process (Opcode) is begin
        case Opcode is
            when opSW =>
                sMemWrite <= '1';
            when others =>
                sMemWrite <= '0';
        end case;
    end process MemWrite_proc;

    ALUControl_proc : process (Opcode, Funct) is begin
        case Opcode is
            when "000000" =>
                case Funct is
                    when opADD =>
                        sALUControl <= "0100";
                    when opSUB =>
                        sALUControl <= "0101";
                    when opAND =>
                        sALUControl <= "1010";
                    when opOR =>
                        sALUControl <= "1000";
                    when opMULTU =>
                        sALUControl <= "0110";
                    when opSLL =>
                        sALUControl <= "1100";
                    when opSRA =>
                        sALUControl <= "1110";
                    when opSRL =>
                        sALUControl <= "1101";
                    when opXOR =>
                        sALUControl <= "1011";
                    when others =>
                        sALUControl <= "0000";
                end case;
            when opADDI =>
                sALUControl <= "0100";
            when opANDI =>
                sALUControl <= "1010";
            when opORI =>
                sALUControl <= "1000";
            when opXORI =>
                sALUControl <= "1011";
            when others =>
                sALUControl <= "0000";
        end case;
    end process ALUControl_proc;

    ALUSrc_proc : process (Opcode) is begin
        case Opcode is
            when opADDI | opANDI | opORI | opXORI | opLW | opSW =>
                sALUSrc <= '1';
            when others =>
                sALUSrc <= '0';
        end case;
    end process ALUSrc_proc;

    RegDst_proc : process (Opcode) is begin
        case Opcode is
            when "000000" =>
                sRegDst <= '1';
            when opADDI | opANDI | opORI | opXORI | opLW | opSW =>
                sRegDst <= '0';
            when others =>
                sRegDst <= '0';
        end case;
    end process RegDst_proc;

    RegWrite <= sRegWrite;
    MemtoReg <= sMemtoReg;
    MemWrite <= sMemWrite;
    ALUControl <= sALUControl;
    ALUSrc <= sALUSrc;
    RegDst <= sRegDst;

end Behavioral;
