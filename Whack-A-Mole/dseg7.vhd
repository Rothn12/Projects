library ieee;
use ieee.std_logic_1164.all;

package dseg7 is

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
	
	-- The alphabet with a decimal
	constant active_low_ad : std_logic_vector(7 downto 0) := B"00001000";
	constant active_low_bd : std_logic_vector(7 downto 0) := B"00000011";
	constant active_low_cd : std_logic_vector(7 downto 0) := B"00100111";
	constant active_low_dd : std_logic_vector(7 downto 0) := B"00100001";
	constant active_low_ed : std_logic_vector(7 downto 0) := B"00000110";
	constant active_low_fd : std_logic_vector(7 downto 0) := B"00001110";
	constant active_low_gd : std_logic_vector(7 downto 0) := B"01000010";
	constant active_low_hd : std_logic_vector(7 downto 0) := B"00001011";
	constant active_low_id : std_logic_vector(7 downto 0) := B"01111011";
	constant active_low_jd : std_logic_vector(7 downto 0) := B"01100001";
	constant active_low_kd : std_logic_vector(7 downto 0) := B"00001010";
	constant active_low_Ld : std_logic_vector(7 downto 0) := B"01000111";
   constant active_low_md : std_logic_vector(7 downto 0) := B"01001000";
	constant active_low_nd : std_logic_vector(7 downto 0) := B"00101011";
	constant active_low_od : std_logic_vector(7 downto 0) := B"00100011";
	constant active_low_pd : std_logic_vector(7 downto 0) := B"00001100";
	constant active_low_qd : std_logic_vector(7 downto 0) := B"00011000";
	constant active_low_rd : std_logic_vector(7 downto 0) := B"00101111";
	constant active_low_sd : std_logic_vector(7 downto 0) := B"00010011";
	constant active_low_td : std_logic_vector(7 downto 0) := B"00000111";
	constant active_low_ud : std_logic_vector(7 downto 0) := B"01100011";
	constant active_low_vd : std_logic_vector(7 downto 0) := B"01000001";
	constant active_low_wd : std_logic_vector(7 downto 0) := B"00000001";
	constant active_low_xd : std_logic_vector(7 downto 0) := B"00001001";
	constant active_low_yd : std_logic_vector(7 downto 0) := B"00010001";
	constant active_low_zd : std_logic_vector(7 downto 0) := B"01100100";
	
end package dseg7;