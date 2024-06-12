----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2024 04:16:42 PM
-- Design Name: 
-- Module Name: ripple_carry_adder - Behavioral
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
use work.globals.all ;

entity ripple_carry_adder is
    port (
        a : in std_logic_vector(N-1 downto 0);
        b : in std_logic_vector(N-1 downto 0);
        op : in std_logic; -- 0 = add, 1 = subtract
        result : out std_logic_vector(N-1 downto 0) -- same size as input bit
        );
end ripple_carry_adder;

architecture Behavioral of ripple_carry_adder is
    signal carry : std_logic_vector(N-1 downto 0);
    signal carry_out : std_logic;
    signal sig : std_logic_vector(N-1 downto 0);
begin
sig <= b xor op; 
    firstAdder : entity work.full_adder
        port map (
            A => a(0),
            B => sig(0),
            Cin => op,
            result => result(0),
            C_out => carry(0)
        );
    FAarray : for i in 1 to N-1 generate
        full_adder : entity work.full_adder
            port map (
                A => a(i),
                B => sig(i),
                Cin => carry(i-1),
                result => result(i),
                C_out => carry(i)
            );
    end generate FAarray;
    carry_out <= carry(N-1);

end Behavioral;
