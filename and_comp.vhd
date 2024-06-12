library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity andN is
    generic (N : INTEGER := 32);
    PORT (
        A : IN std_logic_vector(N-1 downto 0);
        B : IN std_logic_vector(N-1 downto 0);
        Y : OUT std_logic_vector(N-1 downto 0)
        );

end entity andN;

architecture Behavioral of andN is
begin
    Y <= A and B;
end Behavioral;