----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2024 01:58:47 PM
-- Design Name: 
-- Module Name: InstuctionMemory - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity InstructionMemory is
    port (
        addr : in STD_LOGIC_VECTOR (27 downto 0);
        d_out : out STD_LOGIC_VECTOR (31 downto 0)
    );
end InstructionMemory;

architecture Behavioral of InstructionMemory is
type memory_file is array (0 to 1023) of std_logic_vector (7 downto 0);
signal mem : memory_file :=(
    x"00",x"00",x"00",x"00", 

    /* load value of 4 into register R1 using ORI with R0 
    -- ORI $1, $0, 0x04  | Op-code | rs  |  rt   |     imm          |
    32x"34010004"          001101   00000  00001   0000000000000100           */
	x"34",x"01",x"00",x"04",
	
    --follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00", 
    
    /* load value of 3 into register R2 using ORI with R0 
    -- ORI $2, $0, 0x03  | Op-code | rs  |  rt   |     imm          |
    32x"34020003"          001101   00000  00010   0000000000000011         */
    x"34",x"02",x"00",x"03",

   --follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00", 

    /* Add value in R2(exp 3) to value in R1(exp 4) store result in R3 (exp 7)  
    ADD $3, $1, $2  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00221820"      000000  00001   00010   00011  00000    100000       */
    x"00",x"22",x"18",x"20",

    --follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00", 

    /* store value from R3 (should be 7) into mem addr(rs offset by imm) [0]
    -- SW $3, 0($0)      | Op-code | rs   |  rt   |     imm          |
    32x"AC030000"          101011   00000  00011   0000000000000000         */
    x"AC",x"03",x"00",x"00",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00", 

    /* Load value from mem addr(rs = 0  offset by imm = 0) [0] into r4 (exp 7)
    -- LW $4, 0($0)      | Op-code | rs   |  rt   |     imm          |
    32x"8C040000"          100011   00000  00100   0000000000000000         */
	x"8C",x"04",x"00",x"00",

	--follow prev with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
    x"00",x"00",x"00",x"00",

	/* AND value in R4(exp 7) with value in R2(exp 3) and store result back in R4 (exp 3)  
    AND $4, $4, $2  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00822024"      000000  00100   00010   00100  00000    100100       */
	x"00",x"82",x"20",x"24",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 
	
	/* SUB value in R2(exp 3) from value in R1(exp 4) and store result in R4 (exp 1)  
    SUB $4, $1, $2  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00222022"      000000  00001   00010   00100  00000    100010       */
	x"00",x"22",x"20",x"22",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/* SLLV value in R3(exp 7) by value in R2(exp 3) and store result in R5 (exp 56 aka 0x38)  
         rd, rt, rs
    SLLV R5, R2, R3  | Op-code | rs   | rt    |   rd | sh_amt | function (fake) |
    32x"00622800"      000000   00011  00010   00101  00000     000000       */
	x"00",x"62",x"28",x"00",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/* SUB value in R5(exp 56) from value in R1(exp 4) and store result in R6 (exp -52 0xffffffCC)  
    SUB R6, R1, R5  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00253022"      000000  00001   00101   00110  00000    100010       */
	x"00",x"25",x"30",x"22",
	
	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/*  SRAV value in R6(exp -52) by value in R4(exp 1) and store result in R7 (exp -25 aka 0xFFFFFFE6)  
    rd=rt>>rs	jk tho because swapped this all around and it works??
	         rd, rs, rt this could all be lies and propoganda
	    SRAV R7, R4, R6  | Op-code | rs   | rt    |   rd | sh_amt | function (fake) |
        32x"00C43803"      000000   00110  00100   00111  00000     000011       */
	x"00",x"C4",x"38",x"03",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/*  SRLV value in R7(exp -25 aka FFFFFFE6) by value in R4(exp 1) and store result in R8 
    (exp 2,147,483,635 aka 0x7FFFFFF3)  
			 rd, rs, rt this could all be lies and propoganda
	    SRLV R8, R4, R6  | Op-code | rs   | rt    |   rd | sh_amt | function (fake) |
        32x"00E44002"      000000   00111  00100   01000  00000     000010       */
	x"00",x"e4",x"40",x"02",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/* XOR value in R8(2,147,483,635 aka 0x7FFFFFF3) with value in R7(exp -25 aka 0xFFFFFFE6) and 
    store result in r9 (exp -2,147,483,627 aka 0x80000015)  
    XOR R9, R7, R8  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00E84826"      000000  00111   01000   01001  00000    100110       */
	x"00",x"E8",x"48",x"26",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 
	
	/* MULTU value in R2(exp 3) from value in R1(exp 4) and store result in R10 (exp 12 aka 0xC)  
    MULTU R10, R1, R2  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00225019"        000000    00001   00010  01010  00000    011001       */
	x"00",x"22",x"50",x"19",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/* OR value in R2(exp 3) from value in R1(exp 4) and store result in R11 (exp 7)  
    OR R11, R1, R2  | Op-code | rs   | rt    |   rd | sh_amt | function |
    32x"00225019"     000000    00001   00010  01011  00000    100101       */
	x"00",x"22",x"58",x"25",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/* XORI value in R10(exp 12 aka 0xC) with imm 0x3 and store result in R12(exp 15 aka 0xF)
    -- XORI R12, R10, 0x03  | Op-code | rs  |  rt   |     imm          |
    32x"394C0003"         	 001110    01010  01100   0000000000000011           */
	x"39",x"4C",x"00",x"03",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00", 

	/* ANDI value in R10(exp 12 aka 0xC) with imm 0xC and store result in R13(exp 12 aka 0xC)
    -- ANDI R13, R12, 0xC  | Op-code | rs  |  rt   |     imm          |
    32x"318D000C"         	 001100    01100  01101   0000000000001100           */
	x"31",x"8D",x"00",x"0C",

	--follow it with three NOPs
    x"00",x"00",x"00",x"00", 
    x"00",x"00",x"00",x"00",
	x"00",x"00",x"00",x"00",

	/* ADDI value in R10(exp 12 aka 0xC) with imm 0xC and store result in R14(exp 24 aka 0x18)
    -- ADDI R14, R10, 0xC  | Op-code | rs  |  rt   |     imm          |
    32x"214E000C"         	 001000   01010  01110   0000000000001100           */
	x"21",x"4E",x"00",x"0C",
    
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
