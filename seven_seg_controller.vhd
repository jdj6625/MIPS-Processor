-------------------------------------------------
--  File:          seven_seg_refresh_counter.vhd
--
--  Entity:        seven_seg_refresh_counter
--  Architecture:  BEHAVIORAL
--  Author:        Jason Blocklove
--  Created:       10/20/19
--  Modified:
--  VHDL'93
--  Description:   The following is the entity and
--                 architectural description of a
--                 refresh controller for the
--                 7-segment display
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SevenSegController is
	port(
	clk	: in std_logic;
	rst : in std_logic;
	display_number : in std_logic_vector(15 downto 0);
	active_segment : out std_logic_vector(3 downto 0);
	led_out : out std_logic_vector(6 downto 0)
	);
end SevenSegController;
architecture Behavioral of SevenSegController is
	signal refresh_counter : unsigned(19 downto 0);
	signal led_active_counter : std_logic_vector(1 downto 0);

	component BCDSevenSegConverter is
		Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
			   seg7 : out  STD_LOGIC_VECTOR (6 downto 0)
		 );
	end component;

	signal led_bcd : std_logic_vector(3 downto 0);

begin


	BCDSevenSegConverter_0 : BCDSevenSegConverter
		port map (
			A  => led_bcd,
			seg7  => led_out
		);

	refresh_count_proc:process(clk, rst)
	begin
		if (rst = '1') then
			refresh_counter <= (others => '0');
		elsif (clk'event and clk = '1') then
			refresh_counter <= refresh_counter+1;
		end if;
	end process;
	led_active_counter <= std_logic_vector(refresh_counter(19 downto 18));

	led_active_proc:process(led_active_counter, display_number)
	begin
		case led_active_counter is
			when "00" =>
				active_segment <= "0111";
				led_bcd <= display_number(15 downto 12);
			when "01" =>
				active_segment <= "1011";
				led_bcd <= display_number(11 downto 8);
			when "10" =>
				active_segment <= "1101";
				led_bcd <= display_number(7 downto 4);
			when OTHERS =>
				active_segment <= "1110";
				led_bcd <= display_number(3 downto 0);
		end case;
	end process;
end Behavioral;
