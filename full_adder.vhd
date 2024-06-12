----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2024 04:22:05 PM
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder is
    Port ( 
        A : in std_logic;
        B : in std_logic;
        Cin : in std_logic;
        result : out std_logic;
        C_out : out std_logic
    );
end full_adder;

architecture Behavioral of full_adder is
begin
    result <= A xor B xor Cin;
    C_out <= (A and B) or (B and Cin) or (A and Cin);
end Behavioral;
