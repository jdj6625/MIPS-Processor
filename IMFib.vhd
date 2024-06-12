----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/25/2024 05:50:39 PM
-- Design Name: 
-- Module Name: IMFib - Behavioral
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

entity IMFib is
    port (
        addr : in STD_LOGIC_VECTOR (27 downto 0);
        d_out : out STD_LOGIC_VECTOR (31 downto 0)
    );
end IMFib;

architecture Behavioral of IMFib is
type memory_file is array (0 to 1023) of std_logic_vector (7 downto 0);
signal mem : memory_file :=(
    x"00",x"00",x"00",x"00",		

	-- below the following line are the MIPS fib instructions
	------------------------------------------------------------------------------------------------

	-- 0x340A0000				load value of t1 = 0 into register R10: 
	x"34",x"0A",x"00",x"00",	-- ORI R10, R0, 0x0 	# R10 <= $zero | 0x0
	x"00",x"00",x"00",x"00", 		 
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",		
	-- 0xAC0A0000				store t1 aka fib(n=1) into data memory
	x"AC",x"0A",x"00",x"00",	-- SW R10, 0x0(R0) 		# Mem[$zero + 0] <= R10
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",


	-- 0x340B0001				load value of t2 = 1 into register R11: 
	x"34",x"0B",x"00",x"01",	-- ORI R11, R0, 0x1		# R11 <= 1 = $zero | 0x1
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC0B0001				store t2 aka fib(n=2) into data memory
	x"AC",x"0B",x"00",x"01",	-- SW R11, 0x1(R0) 		# Mem[$zero + 1] <= R11
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",

	
	-- 0x016A6020
	x"01",x"6A",x"60",x"20",	-- ADD R12, R11, R10 	# R12 <= fib(n=3) = fib(n=2) + fib(n=1)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC0C0002
	x"AC",x"0C",x"00",x"02",	-- SW R12, 0x2(R0) 		# Mem[$zero + 2] <= R12
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",


	-- 0x018B6820
	x"01",x"8B",x"68",x"20",	-- ADD R13, R12, R11 	# R13 <= fib(n=4) = fib(n=3) + fib(n=2)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC0D0003
	x"AC",x"0D",x"00",x"03",	-- SW R13, 0x3(R0) 		# Mem[$zero + 3] <= R13
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",

	
	-- 0x01AC7020
	x"01",x"AC",x"70",x"20",	--ADD R14, R13, R12 	# R14 <= fib(n=5) = fib(n=4) + fib(n=3)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC0E0004
	x"AC",x"0E",x"00",x"04",	-- SW R14, 0x4(R0) 		# Mem[$zero + 4] <= R14
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",

	
	-- 0x01CD7820
	x"01",x"CD",x"78",x"20",	-- ADD R15, R14, R13		# R15 <= fib(n=6) = fib(n=5) + fib(n=4)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC0F0005
	x"AC",x"0F",x"00",x"05",	-- SW R15, 0x5(R0) 			# Mem[$zero + 5] <= R15
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",


	-- 0x01EE8020
	x"01",x"EE",x"80",x"20",	-- ADD R16, R15, R14		# R16 <= fib(n=7) = fib(n=6) + fib(n=5)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC100006
	x"AC",x"10",x"00",x"06",	-- SW R16, 0x6(R0) 			# Mem[$zero + 6] <= R16
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",

	
	-- 0x020F8820
	x"02",x"0F",x"88",x"20",	-- ADD R17, R16, R15		# R17 <= fib(n=8) = fib(n=7) + fib(n=6)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC110007
	x"AC",x"11",x"00",x"07",	-- SW R17, 0x7(R0) 			# Mem[$zero + 7] <= R17
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",

	
	-- 0x02309020
	x"02",x"30",x"90",x"20",	-- ADD R18, R17, R16		# R18 <= fib(n=9) = fib(n=8) + fib(n=7)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC120008
	x"AC",x"12",x"00",x"08",	-- SW R18, 0x8(R0) 			# Mem[$zero + 8] <= R18
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",


	-- 0x02519820
	x"02",x"51",x"98",x"20",	-- ADD R19, R18, R17		# R19 <= fib(n=10) = fib(n=9) + fib(n=8)
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
	-- 0xAC130009
	x"AC",x"13",x"00",x"09",	-- SW R19, 0x9(R0) 			# Mem[$zero + 9] <= R19
	x"00",x"00",x"00",x"00", 		
	x"00",x"00",x"00",x"00",		 
	x"00",x"00",x"00",x"00",
    
    others =>x"00");
begin
   process (addr)    
    begin
        if (to_integer(unsigned(addr)) >= 0 and to_integer(unsigned(addr)) <= 1020) then
            d_out <= mem(to_integer(unsigned(addr))) & mem(to_integer(unsigned(addr)) + 1) 
            & mem(to_integer(unsigned(addr)) + 2) & mem(to_integer(unsigned(addr)) + 3);
        else
            d_out <= x"00000000";
        end if; 
    end process;
end Behavioral;
