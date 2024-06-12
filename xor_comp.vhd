library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xorN is
    generic (N : INTEGER := 32);
    PORT (
        A : IN std_logic_vector(N-1 downto 0);
        B : IN std_logic_vector(N-1 downto 0);
        Y : OUT std_logic_vector(N-1 downto 0)
        );

end entity xorN;

architecture Behavioral of xorN is
begin
    Y <= A xor B;
end Behavioral;