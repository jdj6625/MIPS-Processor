------------------------------------------------------
-- Company : Rochester Institute of Technology (RIT )
-- Engineer : <YOUR_NAME_HERE > ( < YOUR_EMAIL_HERE >)
--
-- Create Date : <CREATION_TIME_HERE >
-- Design Name : alu4
-- Module Name : alu4 - structural
-- Project Name : <PROJECT_NAME_HERE >
-- Target Devices : Basys3
--
-- Description : Partial 4 -bit Arithmetic Logic Unit
-- ----------------------------------------------------
library IEEE ;
use IEEE.STD_LOGIC_1164.ALL ;
use IEEE.NUMERIC_STD.ALL;
use work.globals.all ;

entity alu32 is
    PORT (
            A : IN std_logic_vector (N-1 downto 0);
            B : IN std_logic_vector (N-1 downto 0);
            OP : IN std_logic_vector (3 downto 0);
            Y : OUT std_logic_vector (N-1 downto 0)
          );
end alu32 ;

architecture structural of alu32 is
    signal not_result : std_logic_vector (N -1 downto 0);
    signal sll_result : std_logic_vector (N -1 downto 0);
    signal srl_result : std_logic_vector (N -1 downto 0);
    signal or_result  : std_logic_vector (N -1 downto 0);
    signal and_result : std_logic_vector (N -1 downto 0);
    signal xor_result : std_logic_vector (N -1 downto 0);
    signal sra_result : std_logic_vector (N -1 downto 0);
    signal rca_result : std_logic_vector (N -1 downto 0);
    signal csm_result : std_logic_vector (N -1 downto 0);
begin
    -- Instantiate the inverter , using component
    not_comp : entity work.notN
    generic map ( N => N )
    port map ( A => A , Y => not_result ) ;
    
    -- Instantiate the SLL unit , without component
    sll_comp : entity work.sllN
    generic map ( N => N , M => M )
    port map ( A => A ,SHIFT_AMT => B(M-1 downto 0), Y => sll_result);
    
    -- Instantiate the SRL unit , without component
    srl_comp : entity work.slrN
    generic map ( N => N , M => M )
    port map ( A => A ,SHIFT_AMT => B(M-1 downto 0), Y => srl_result);
    
    -- Instantiate the SRA unit , without component
    sra_comp : entity work.sarN
    generic map ( N => N , M => M )
    port map ( A => A ,SHIFT_AMT => B(M-1 downto 0), Y => sra_result);
    
    --  OR Instance
    or_comp : entity work.orN
    generic map (N => N)
    port map (A => A, B => B, Y => or_result);
    
    -- Logical AND Instance
    and_comp : entity work.andN
    generic map (N => N)
    port map (A => A, B => B, Y => and_result);
    
    -- Logical XOR Instance
    xor_comp : entity work.xorN
    generic map (N => N)
    port map (A => A, B => B, Y => xor_result);
    
    addsub_comp : entity work.ripple_carry_adder
    port map (A => A, B => B, OP => OP(0), result => rca_result);
    
    multiply_comp : entity work.carrysavemult
    port map (A => A(15 downto 0), B => B(15 downto 0), product => csm_result);    
    
    
    Y <= not_result when OP = "0000" else -- NOT
         or_result  when OP = "1000" else
         and_result when OP = "1010" else
         xor_result when OP = "1011" else
         sll_result when OP = "1100" else
         srl_result when OP = "1101" else
         sra_result when OP = "1110" else
         rca_result when OP = "0101" else
         rca_result when OP = "0100" else
         csm_result; -- when OP = "0110" else
    
end structural;
