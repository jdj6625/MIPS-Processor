-- ----------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : <YOUR_NAME_HERE > ( < YOUR_EMAIL_HERE >)
--
-- Create Date : <CREATION_TIME_HERE >
-- Design Name : aluTB
-- Module Name : aluTB - behavioral
-- Project Name : <PROJECT_NAME_HERE >
--
-- Description : Testbec \nch for Partial 32 - bit ALU
-- ----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all;

entity aluTB is
end aluTB;

architecture Behavioral of aluTB is
--Declare the ALU component
    Component alu4 is
        PORT (
            A   : IN std_logic_vector(N-1 downto 0);
            B   : IN std_logic_vector(N-1 downto 0);
            OP  : IN std_logic;
            Y   : OUT std_logic_vector(N-1 downto 0)
        );
    end Component;
    
    constant delay : time := 20 ns;
    signal A, B, Y : std_logic_vector(N-1 downto 0) := (others => '0');
    signal OP      : std_logic := '0';
    
begin
    -- Instantiate an instance of the ALU
    alu_inst: alu4 PORT MAP (
        A => A,
        B => B,
        OP => OP,
        Y => Y
    );
    
    data_proc: process is
    begin
        for i in 0 to 7 loop
            wait for delay;
            A <= std_logic_vector(unsigned(A) + 1);
        end loop;
        
        wait for delay;
        
        OP <= '1';
        
        for i in 1 to 7 loop
            A <= std_logic_vector(unsigned(A) + 1);
            for j in 0 to 3 loop
                wait for delay;
                B <= std_logic_vector((unsigned (B) + 1) mod 4);
            end loop;
        end loop;
        
        wait;
        
     end process;
end Behavioral;
        
    