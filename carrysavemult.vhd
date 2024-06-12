----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2024 04:44:23 PM
-- Design Name: 
-- Module Name: carrysavemult - Behavioral
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
use work.globals.all ;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity carrysavemult is
    port (
        a : in std_logic_vector((N/2)-1 downto 0); -- half the size of output
        b : in std_logic_vector((N/2)-1 downto 0); -- half the size of output
        product : out std_logic_vector(N-1 downto 0)
    );
end carrysavemult;

architecture Behavioral of carrysavemult is
    type and_array is array((N/2)-1 downto 0) of std_logic_vector((N/2)-1 downto 0);
    type carry_array is array((N/2)-1 downto 1) of std_logic_vector((N/2)-1 downto 0);
    type sum_array is array((N/2)-1 downto 0) of std_logic_vector((N/2)-1 downto 0);

    signal temp: and_array;
    signal c_int : carry_array := (others => (others => '0'));
    signal fa : sum_array;
    signal prod : std_logic_vector(N-1 downto 0);
begin
rows : for row in 0 to (N/2)-1 generate

            columns : for col in 0 to (N/2)-1 generate

                mults : temp(row)(col) <= b(row) and a(col);

                carry_through: if row = 0 and col = 0 generate
                    prod(row) <= temp(row)(col);
                end generate;

                first_adder: if row = 1 and col = 0 generate
                    init_adder : entity work.full_adder
                        port map (
                            A => temp(row)(col),
                            B => temp(row-1)(col+1),
                            Cin => '0',
                            result => prod(row),
                            C_out => c_int(row)(col)
                        );
                end generate;

                first_row_center : if row = 1 and col > 0 and col < (N/2)-1  generate
                    first_row_center_adder : entity work.full_adder
                        port map (
                            A => temp(row)(col),
                            B => temp(row-1)(col+1),
                            Cin => temp(row+1)(col-1),
                            result => fa(row)(col),
                            C_out => c_int(row)(col)
                        );
                end generate;

                first_row_last : if row = 1 and col = (N/2)-1 generate
                    first_row_last_adder : entity work.full_adder
                        port map (
                            A => temp(row)(col),
                            B => '0',
                            Cin => temp(row+1)(col-1),
                            result => fa(row)(col),
                            C_out => c_int(row)(col)
                        );
                end generate;

                center_right_edge : if row > 1 and row < (N/2)-1 and col = 0 generate
                    center_right_edge_adder : entity work.full_adder
                        port map (
                            A => '0',
                            B => fa(row-1)(col+1),
                            Cin => c_int(row-1)(col),
                            result => prod(row),
                            C_out => c_int(row)(col)
                        );
                end generate;

                center_left_edge : if row > 1 and row < (N/2)-1 and col = (N/2)-1 generate
                    center_left_edge_adder : entity work.full_adder
                        port map (
                            A => temp(row+1)(col-1),
                            B => temp(row)(col),
                            Cin => c_int(row-1)(col),
                            result => fa(row)(col),
                            C_out => c_int(row)(col)
                        );
                end generate;

                center : if row > 1 and row < (N/2)-1 and col > 0 and col < (N/2)-1 generate
                    center_adder : entity work.full_adder
                        port map (
                            A => temp(row+1)(col-1),
                            B => fa(row-1)(col+1),
                            Cin => c_int(row-1)(col),
                            result => fa(row)(col),
                            C_out => c_int(row)(col)
                        );
                end generate;

                last_row_right_edge : if row = (N/2)-1 and col = 0 generate
                    last_row_right_edge_adder : entity work.full_adder
                        port map (
                            A => c_int(row-1)(col),
                            B => fa(row-1)(col+1),
                            Cin => '0',
                            result => prod(row),
                            C_out => c_int(row)(col)
                        );
                end generate;

                last_row_center : if row = (N/2)-1 and col > 0 and col < (N/2)-1 generate
                    last_row_center_adder : entity work.full_adder
                        port map (
                            A => c_int(row-1)(col),
                            B => fa(row-1)(col+1),
                            Cin => c_int(row)(col-1),
                            result => prod(row+col),
                            C_out => c_int(row)(col)
                        );
                end generate;

                last_row_left_edge : if row = (N/2)-1 and col = (N/2)-1 generate
                    last_row_left_edge_adder : entity work.full_adder
                        port map (
                            A => c_int(row-1)(col),
                            B => temp(row)(col),
                            Cin => c_int(row)(col-1),
                            result => prod(row+col),
                            C_out => prod(row+col+1)
                        );
                end generate;

            end generate columns;

        end generate rows;

        product <= prod;

end Behavioral;
