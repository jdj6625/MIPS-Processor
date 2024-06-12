-------------------------------------------------
--  File:          aluTB.vhd
--
--  Entity:        aluTB
--  Architecture:  Testbench
--  Author:        Jason Blocklove
--  Created:       07/29/19
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                aluTB
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all;

entity aluTB is
 
end aluTB;

architecture tb of aluTB is

component alu32 IS
    Port ( A : in  std_logic_vector(N-1 downto 0);
           B : in  std_logic_vector(N-1 downto 0);
           OP : in  std_logic_vector(3 downto 0);
           Y    : out std_logic_vector(N-1 downto 0)
          );
end component;

signal A : std_logic_vector(N-1 downto 0);
signal B : std_logic_vector(N-1 downto 0);
signal OP : std_logic_vector(3 downto 0);
signal Y : std_logic_vector(N-1 downto 0);

type test_vector is record
	-- Test Inputs
	A : std_logic_vector(31 downto 0);
	B : std_logic_vector(31 downto 0);
	OP : std_logic_vector(3 downto 0);
	-- Test Outputs
	Y : std_logic_vector(31 downto 0);
end record;

type test_array is array (natural range <>) of test_vector;

--TODO: Add at least 2 cases for each operation in the ALU
constant test_vector_array : test_array :=(
	(A => x"00000001", B => x"00000001", OP => "1010", Y => x"00000001"),
	(A => x"00000001", B => x"00000000", OP => "1010", Y => x"00000000"),
	(A => x"00000001", B => x"00000001", OP => "0100", Y => x"00000002"),
	(A => x"00000003", B => x"00000003", OP => "0100", Y => x"00000006"),
	(A => x"00000001", B => x"00000001", OP => "0101", Y => x"00000000"),
	(A => x"00000004", B => x"00000002", OP => "0101", Y => x"00000002"),
	(A => x"00000001", B => x"00000000", OP => "1000", Y => x"00000001"),
	(A => x"00000000", B => x"00000000", OP => "1000", Y => x"00000000"),
	(A => x"00000002", B => x"00000002", OP => "0110", Y => x"00000004"),
	(A => x"00000004", B => x"00000004", OP => "0110", Y => x"00000010"),
	(A => x"00000001", B => x"00000001", OP => "1100", Y => x"00000002"),
	(A => x"00000001", B => x"00000000", OP => "1100", Y => x"00000001"),
	(A => x"80000000", B => x"00000001", OP => "1110", Y => x"c0000000"),
	(A => x"00000004", B => x"00000001", OP => "1110", Y => x"00000002"),
	(A => x"80000000", B => x"00000001", OP => "1101", Y => x"40000000"),
	(A => x"00000004", B => x"00000001", OP => "1101", Y => x"00000002"),
	(A => x"00000001", B => x"00000001", OP => "1011", Y => x"00000000"),
	(A => x"00000001", B => x"00000000", OP => "1011", Y => x"00000001")
);

begin


aluN_0 : alu32
    port map (
			A   => A,
			B   => B,
            OP  => OP,
            Y   => Y
		);

	stim_proc:process
	begin

		for i in test_vector_array'range loop
		A <= test_vector_array(i).A;
		B <= test_vector_array(i).B;
		OP <= test_vector_array(i).OP;
			
		assert (Y = test_vector_array(i).Y) report "the result for ALU op :" & to_hstring(test_vector_array(i).OP) 
		& " is " & to_hstring(Y) & " and should be " & to_hstring(test_vector_array(i).Y);
		--TODO:	signal assignments and assert statements
			wait for 100 ns;
		end loop;


		assert false
		  report "Testbench Concluded."
		  severity failure;

	end process;
end tb;
