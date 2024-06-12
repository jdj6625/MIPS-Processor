library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is
    port (
        clk         : in std_logic;
        w_en        : in std_logic;
        addr        : in std_logic_vector(9 downto 0);
        d_in        : in std_logic_vector(31 downto 0);
        switches    : in std_logic_vector(15 downto 0);

        d_out       : out std_logic_vector(31 downto 0);
        seven_seg   : out std_logic_vector(15 downto 0)
    );
end data_memory;

architecture behavioral of data_memory is
    type memory_array is array (2**10-1 downto 0)
        of std_logic_vector(31 downto 0);
    signal mem : memory_array := (others => (others => '0'));

begin
    process(clk)
    begin
        if clk'event and clk = '1' then
            if w_en = '1' then
                case addr is
                    when "1111111111" => seven_seg <= d_in(15 downto 0);                    
                    when "1111111110" => NULL;
                    when others => mem(to_integer(unsigned(addr))) <= d_in;                
                end case;
            end if;
            case addr is
                when "1111111111" => NULL;                    
                when "1111111110" => d_out <= x"0000" & switches;
                when others => d_out <= mem(to_integer(unsigned(addr)));               
            end case;          
        end if;
    end process;
end behavioral;