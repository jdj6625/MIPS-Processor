-------------------------------------------------
--  File:          Example.vhd
--  Author:        Robbie Riviere
--  Created:       12/28/2021
--  Description:   This file is an example for VHDL testbenches.
--                 There are many ways to create testbenches, this is just one way.
-------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all;

-- Entity
entity alu32tb is -- In a testbench an entity does not have ports
end alu32tb;

-- Architecture
architecture Behavioral of alu32tb is
-- Between the is and begin keywords is where you would declare your signals, constants, and variables, etc.

-- The following is an example of a function that converts a std_logic_vector to a string, which is useful for debugging.
-- It can be used in your assert statements to print out the current value of a signal.
--- Usage example: vec2str(C) will return a string with the value of the signal C
function vec2str(vec: std_logic_vector) return string is
        variable stmp: string(vec'high+1 downto 1);
        variable counter : integer := 1;
    begin
        for i in vec'reverse_range loop
            stmp(counter) := std_logic'image(vec(i))(2); -- image returns '1' (with quotes)
            counter := counter + 1;
        end loop;
        return stmp;
    end vec2str;

-- In this section declare the component being tested
component alu32 is
    port(
        A : in std_logic_vector(N-1 downto 0);
        B : in std_logic_vector(N-1 downto 0);
        OP : in std_logic_vector(3 downto 0);
        Y : out std_logic_vector(N-1 downto 0)
    );
end component;

-- In this section declare the signals that will be used to connect the testbench to the component being tested
-- No need to declare input/output here, they are declared in the component declaration
-- Example:
signal A : std_logic_vector(N-1 downto 0);
signal B : std_logic_vector(N-1 downto 0);
signal OP : std_logic_vector(3 downto 0);
signal Y : std_logic_vector(N-1 downto 0);

-- Next, declare a record type that will be used to store the testbench inputs and outputs
-- Example:
type alurecord is record -- This is the name of the record type, it can be anything
    -- The inputs/outputs of the testbench go here
    A : std_logic_vector(N-1 downto 0);
    B : std_logic_vector(N-1 downto 0);
    OP : std_logic_vector(3 downto 0);
    Y : std_logic_vector(N-1 downto 0);
end record;

--Now Declare a test vector array that will store the testbench inputs and outputs
-- Example:
type testarray is array(natural range <>) of alurecord; -- Natural range is the range of natural numbers, which will be used to index the array
constant const : testarray := (
    -- Test vector values go here, in the order defined in the record
    -- Example: clk, A, B, C
    (32x"1", 32x"0", "1000", 32x"1"), -- This is the first test vector, It is a record with the values clk=0, A="0000", B="0000", C="0000"
    (32x"2", 32x"0", "1000", 32x"2"), -- These vectors are assigning the input/output values to the testbench signals
    (32x"3", 32x"0", "1000", 32x"3"), -- The outputs in the test vector is the expected output of the current test 
    (32x"4", 32x"0", "1000", 32x"4"),
    (32x"1", 32x"0", "1010", 32x"0"), -- This is the first test vector, It is a record with the values clk=0, A="0000", B="0000", C="0000"
    (32x"2", 32x"0", "1010", 32x"0"), -- These vectors are assigning the input/output values to the testbench signals
    (32x"3", 32x"0", "1010", 32x"0"), -- The outputs in the test vector is the expected output of the current test 
    (32x"4", 32x"0", "1010", 32x"0"),
    (32x"1", 32x"0", "1011", 32x"1"), -- This is the first test vector, It is a record with the values clk=0, A="0000", B="0000", C="0000"
    (32x"2", 32x"0", "1011", 32x"2"), -- These vectors are assigning the input/output values to the testbench signals
    (32x"3", 32x"0", "1011", 32x"3"), -- The outputs in the test vector is the expected output of the current test 
    (32ux"4", 32x"0", "1011", 32x"4"),
    ("00000000000000000000000000000001", "00000000000000000000000000000001", "1100", "00000000000000000000000000000010"), -- This is the first test vector, It is a record with the values clk=0, A="0000", B="0000", C="0000"
    ("00000000000000000000000000000001", "00000000000000000000000000000010", "1100", "00000000000000000000000000000100"),
    ("00000000000000000000000000000001", "00000000000000000000000000000011", "1100", "00000000000000000000000000001000"),
    ("00000000000000000000000000000001", "00000000000000000000000000000100", "1100", "00000000000000000000000000010000"),
    ("00000000000000000000000000010000", "00000000000000000000000000000001", "1101", "00000000000000000000000000001000"), -- This is the first test vector, It is a record with the values clk=0, A="0000", B="0000", C="0000"
    ("00000000000000000000000000010000", "00000000000000000000000000000010", "1101", "00000000000000000000000000000100"),
    ("00000000000000000000000000010000", "00000000000000000000000000000011", "1101", "00000000000000000000000000000010"),
    ("00000000000000000000000000010000", "00000000000000000000000000000100", "1101", "00000000000000000000000000000001"),
    ("00000000000000000000000000010001", "00000000000000000000000000000001", "1110", "00000000000000000000000000001000"), -- This is the first test vector, It is a record with the values clk=0, A="0000", B="0000", C="0000"
    ("00000000000000000000000000010000", "00000000000000000000000000000001", "1110", "00000000000000000000000000000100"),
    ("00000000000000000000000000000011", "00000000000000000000000000000001", "1110", "00000000000000000000000000000010"),
    ("00000000000000000000000000000000", "00000000000000000000000000000001", "1110", "00000000000000000000000000000000"),
    ("00000000000000000000000000000110", "00000000000000000000000000000010", "1101", "00000000000000000000000000011000"),
    ("00000000000000000000000000000110", "00000000000000000000000000000001", "1110", "00000000000000000000000000001100"),
    ("00000000000000000000000000000110", "00000000000000000000000000000010", "1101", "00000000000000000000000000011000"),
    ("11110000000000000000000000000000", "00000000000000000000000000000001", "1101", "11100000000000000000000000000001"),
    (32x"0", 32x"0", "1000", 32x"0"),
    (32x"0", "00000000000000000000000000001111", "1000", "00000000000000000000000000001111"),
    ("00000000000000000000000000001111", "00000000000000000000000000001111", "1000", "00000000000000000000000000001111"),
    ("00000000000000000000000000000101", "00000000000000000000000000001010", "1000", "00000000000000000000000000001111"),
    ("00000000000000000000000000001010", "00000000000000000000000000000101", "1000", "00000000000000000000000000001111"),
    ("00000000000000000000000000000000", "00000000000000000000000000000000", "1011", "00000000000000000000000000000000"),
    ("00000000000000000000000000000000", "00000000000000000000000000001111", "1011", "00000000000000000000000000001111"),
    ("00000000000000000000000000001111", "00000000000000000000000000000000", "1011", "00000000000000000000000000001111"),
    ("00000000000000000000000000001111", "00000000000000000000000000001111", "1011", "00000000000000000000000000000000"),
    ("00000000000000000000000000000101", "00000000000000000000000000001010", "1011", "00000000000000000000000000001111"),
    ("00000000000000000000000000001010", "00000000000000000000000000000101", "1011", "00000000000000000000000000001111"),
    ("00000000000000000000000000000000", "00000000000000000000000000000000", "1010", "00000000000000000000000000000000"),
    ("00000000000000000000000000000000", "00000000000000000000000000001111", "1010", "00000000000000000000000000000000"),
    ("00000000000000000000000000001111", "00000000000000000000000000000000", "1010", "00000000000000000000000000000000"),
    ("00000000000000000000000000001111", "00000000000000000000000000001111", "1010", "00000000000000000000000000001111")
);

begin
    -- Here is where you would instantiate the component being tested
    -- Example:
    comp_alu : entity work.alu32
    port map(
        -- Port map goes here
        -- Example:
        A => A,
        B => B,
        OP => OP,
        Y => Y
    );
    -- Here is where you would instantiate the clock generator
    -- Example:
    clk_gen : process
    begin
        --clk <= '0';
        --wait for 10 ns;
        --clk <= '1';
        --wait for 10 ns;
    end process;

    -- Here is where you would instantiate the stimulus process
    -- Example:
    stim_proc : process
    begin
        for i in const'range loop -- This is the range of the test vector array
            -- Here is where you would assign the test vector values to the testbench signals
            -- Example:
            A <= const(i).A;
            B <= const(i).B;
            OP <= const(i).OP;
            
            --DO NOT assign the output signal here, it will be assigned by the component being tested
            wait for 30 ns;
            -- Here is where you would assert the testbench outputs
            -- Example:
            assert (A = const(i).A) report "Test failed at vector " & integer'image(i) & " A = " & vec2str(A) & " at " & time'image(now) & " expected " & vec2str(const(i).A);
            assert (B = const(i).B) report "Test failed at vector " & integer'image(i) & " B = " & vec2str(B) & " at " & time'image(now) & " expected " & vec2str(const(i).B);
            -- The above assert statement will check if the output of the component being tested is equal to the expected output
            -- If it is not equal, it will print out the test vector number, the current value of the output signal, the current time, and the expected output
            -- You can edit the assert statement to print out whatever you want, this is just an example
        end loop;
        assert false report "Testbench Concluded" severity failure; -- This will end the simulation
    end process;
end Behavioral;

