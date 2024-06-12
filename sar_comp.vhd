-- ----------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : <YOUR_NAME_HERE > ( < YOUR_EMAIL_HERE >)
--
-- Create Date : <CREATION_TIME_HERE >
-- Design Name : sllN
-- Module Name : sllN - behavioral
-- Project Name : <PROJECT_NAME_HERE >
-- Target Devices : Basys3
--
-- Description : N-bit logical left shift (SLL ) unit
-- ----------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sarN is
    GENERIC (
        N : INTEGER := 32;    -- bit width
        M : INTEGER := 5      -- shift bits
    );
    PORT (
        A : IN std_logic_vector(N-1 downto 0);
        SHIFT_AMT : IN std_logic_vector(M-1 downto 0);
        Y : OUT std_logic_vector(N-1 downto 0)
    );
end sarN;

architecture behavioral of sarN is
    -- Create array of vectors to hold each of n shifters
    type shifty_array is array(N-1 downto 0) of std_logic_vector(N-1 downto 0);
    signal aSRA : shifty_array;
begin
    generateSRA : for i in 0 to N-1 generate
        aSRA(i)(N-1 downto i) <= A(N-1-i downto 0); 
        right_fill: if i>0 generate
            aSRA(i)(i-1 downto 0) <= (others => A(N-1)); 
        end generate right_fill;
    end generate generateSRA;

    Y <= aSRA(to_integer(unsigned(SHIFT_AMT(M-1 downto 0))));
end behavioral;                
    