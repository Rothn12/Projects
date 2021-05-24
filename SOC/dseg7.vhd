/*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*
*/

library ieee;
use ieee.std_logic_1164.all;

package dseg7 is

	constant active_high_blank : std_logic_vector(7 downto 0) := B"00000000";
	constant active_high_dash : std_logic_vector(7 downto 0) := B"01000000";

	-- THese numbers don't have the decimal
	constant active_high_0 : std_logic_vector(7 downto 0) := B"00111111";
	constant active_high_1 : std_logic_vector(7 downto 0) := B"00000110";
	constant active_high_2 : std_logic_vector(7 downto 0) := B"01011011";
	constant active_high_3 : std_logic_vector(7 downto 0) := B"01001111";
	constant active_high_4 : std_logic_vector(7 downto 0) := B"01100110";
	constant active_high_5 : std_logic_vector(7 downto 0) := B"01101101";
	constant active_high_6 : std_logic_vector(7 downto 0) := B"01111101";
	constant active_high_7 : std_logic_vector(7 downto 0) := B"00100111";
	constant active_high_8 : std_logic_vector(7 downto 0) := B"01111111";
	constant active_high_9 : std_logic_vector(7 downto 0) := B"01101111";

	-- These numbers have the decimal after them
	constant active_high_0d : std_logic_vector(7 downto 0) := B"10111111";
	constant active_high_1d : std_logic_vector(7 downto 0) := B"10000110";
	constant active_high_2d : std_logic_vector(7 downto 0) := B"11011011";
	constant active_high_3d : std_logic_vector(7 downto 0) := B"11001111";
	constant active_high_4d : std_logic_vector(7 downto 0) := B"11100110";
	constant active_high_5d : std_logic_vector(7 downto 0) := B"11101101";
	constant active_high_6d : std_logic_vector(7 downto 0) := B"11111101";
	constant active_high_7d : std_logic_vector(7 downto 0) := B"10100111";
	constant active_high_8d : std_logic_vector(7 downto 0) := B"11111111";
	constant active_high_9d : std_logic_vector(7 downto 0) := B"11101111";

	-- The alphabet without a decimal
	constant active_high_a : std_logic_vector(7 downto 0) := B"01110111";
	constant active_high_b : std_logic_vector(7 downto 0) := B"01111100";
	constant active_high_c : std_logic_vector(7 downto 0) := B"01011000";
	constant active_high_d : std_logic_vector(7 downto 0) := B"01011110";
	constant active_high_e : std_logic_vector(7 downto 0) := B"01111001";
	constant active_high_f : std_logic_vector(7 downto 0) := B"01110001";
	constant active_high_g : std_logic_vector(7 downto 0) := B"00111101";
	constant active_high_h : std_logic_vector(7 downto 0) := B"01110100";
	constant active_high_i : std_logic_vector(7 downto 0) := B"00000100";
	constant active_high_j : std_logic_vector(7 downto 0) := B"00011110";
	constant active_high_k : std_logic_vector(7 downto 0) := B"01110101";
	constant active_high_L : std_logic_vector(7 downto 0) := B"00111000";
   constant active_high_m : std_logic_vector(7 downto 0) := B"00110111";
	constant active_high_n : std_logic_vector(7 downto 0) := B"01010100";
	constant active_high_o : std_logic_vector(7 downto 0) := B"01011100";
	constant active_high_p : std_logic_vector(7 downto 0) := B"01110011";
	constant active_high_q : std_logic_vector(7 downto 0) := B"01100111";
	constant active_high_r : std_logic_vector(7 downto 0) := B"01010000";
	constant active_high_s : std_logic_vector(7 downto 0) := B"01101100";
	constant active_high_t : std_logic_vector(7 downto 0) := B"01111000";
	constant active_high_u : std_logic_vector(7 downto 0) := B"00011100";
	constant active_high_v : std_logic_vector(7 downto 0) := B"00111110";
	constant active_high_w : std_logic_vector(7 downto 0) := B"01111110";
	constant active_high_x : std_logic_vector(7 downto 0) := B"01110110";
	constant active_high_y : std_logic_vector(7 downto 0) := B"01101110";
	constant active_high_z : std_logic_vector(7 downto 0) := B"00011011";
	
	--active low
	constant active_low_blank : std_logic_vector(7 downto 0) := B"11111111";
	constant active_low_dash : std_logic_vector(7 downto 0) := B"10111111";
	
	-- THese numbers don't have the decimal
	constant active_low_0 : std_logic_vector(7 downto 0) := B"11000000";
	constant active_low_1 : std_logic_vector(7 downto 0) := B"11111001";
	constant active_low_2 : std_logic_vector(7 downto 0) := B"10100100";
	constant active_low_3 : std_logic_vector(7 downto 0) := B"10110000";
	constant active_low_4 : std_logic_vector(7 downto 0) := B"10011001";
	constant active_low_5 : std_logic_vector(7 downto 0) := B"10010010";
	constant active_low_6 : std_logic_vector(7 downto 0) := B"10000010";
	constant active_low_7 : std_logic_vector(7 downto 0) := B"11011000";
	constant active_low_8 : std_logic_vector(7 downto 0) := B"10000000";
	constant active_low_9 : std_logic_vector(7 downto 0) := B"10010000";
	
	-- These numbers have the decimal after them
	constant active_low_0d : std_logic_vector(7 downto 0) := B"01000000";
	constant active_low_1d : std_logic_vector(7 downto 0) := B"01111001";
	constant active_low_2d : std_logic_vector(7 downto 0) := B"00100100";
	constant active_low_3d : std_logic_vector(7 downto 0) := B"00110000";
	constant active_low_4d : std_logic_vector(7 downto 0) := B"00011001";
	constant active_low_5d : std_logic_vector(7 downto 0) := B"00010010";
	constant active_low_6d : std_logic_vector(7 downto 0) := B"00000010";
	constant active_low_7d : std_logic_vector(7 downto 0) := B"01011000";
	constant active_low_8d : std_logic_vector(7 downto 0) := B"00000000";
	constant active_low_9d : std_logic_vector(7 downto 0) := B"00010000";
	
	-- The alphabet without a decimal
	constant active_low_a : std_logic_vector(7 downto 0) := B"10001000";
	constant active_low_b : std_logic_vector(7 downto 0) := B"10000011";
	constant active_low_c : std_logic_vector(7 downto 0) := B"10100111";
	constant active_low_d : std_logic_vector(7 downto 0) := B"10100001";
	constant active_low_e : std_logic_vector(7 downto 0) := B"10000110";
	constant active_low_f : std_logic_vector(7 downto 0) := B"10001110";
	constant active_low_g : std_logic_vector(7 downto 0) := B"11000010";
	constant active_low_h : std_logic_vector(7 downto 0) := B"10001011";
	constant active_low_i : std_logic_vector(7 downto 0) := B"11111011";
	constant active_low_j : std_logic_vector(7 downto 0) := B"11100001";
	constant active_low_k : std_logic_vector(7 downto 0) := B"10001010";
	constant active_low_L : std_logic_vector(7 downto 0) := B"11000111";
   constant active_low_m : std_logic_vector(7 downto 0) := B"11001000";
	constant active_low_n : std_logic_vector(7 downto 0) := B"10101011";
	constant active_low_o : std_logic_vector(7 downto 0) := B"10100011";
	constant active_low_p : std_logic_vector(7 downto 0) := B"10001100";
	constant active_low_q : std_logic_vector(7 downto 0) := B"10011000";
	constant active_low_r : std_logic_vector(7 downto 0) := B"10101111";
	constant active_low_s : std_logic_vector(7 downto 0) := B"10010011";
	constant active_low_t : std_logic_vector(7 downto 0) := B"10000111";
	constant active_low_u : std_logic_vector(7 downto 0) := B"11100011";
	constant active_low_v : std_logic_vector(7 downto 0) := B"11000001";
	constant active_low_w : std_logic_vector(7 downto 0) := B"10000001";
	constant active_low_x : std_logic_vector(7 downto 0) := B"10001001";
	constant active_low_y : std_logic_vector(7 downto 0) := B"10010001";
	constant active_low_z : std_logic_vector(7 downto 0) := B"11100100";
	
end package dseg7;