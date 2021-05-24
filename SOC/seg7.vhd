library ieee;
use ieee.std_logic_1164.all;
use work.dseg7.all;

entity seg7 is
port(

	instructuion: in std_logic_vector(31 downto 0);
	hexOut: out std_logic_vector(31 downto 0)

);
end entity seg7;

architecture BEHAVE of seg7 is
begin
	--A large when else, that will grab for the bottom hex
	hexOut(7 downto 0) <= active_high_0   when instructuion(4) = '1' and instructuion(3 downto 0) = X"0" else
								 active_high_1   when instructuion(4) = '1' and instructuion(3 downto 0) = X"1" else
								 active_high_2   when instructuion(4) = '1' and instructuion(3 downto 0) = X"2" else
								 active_high_3   when instructuion(4) = '1' and instructuion(3 downto 0) = X"3" else
								 active_high_4   when instructuion(4) = '1' and instructuion(3 downto 0) = X"4" else
								 active_high_5   when instructuion(4) = '1' and instructuion(3 downto 0) = X"5" else
								 active_high_6   when instructuion(4) = '1' and instructuion(3 downto 0) = X"6" else
								 active_high_7   when instructuion(4) = '1' and instructuion(3 downto 0) = X"7" else
								 active_high_8   when instructuion(4) = '1' and instructuion(3 downto 0) = X"8" else
								 active_high_9   when instructuion(4) = '1' and instructuion(3 downto 0) = X"9" else
								 active_high_a   when instructuion(4) = '1' and instructuion(3 downto 0) = X"A" else
								 active_high_b   when instructuion(4) = '1' and instructuion(3 downto 0) = X"B" else
								 active_high_c   when instructuion(4) = '1' and instructuion(3 downto 0) = X"C" else
								 active_high_d   when instructuion(4) = '1' and instructuion(3 downto 0) = X"D" else
								 active_high_e   when instructuion(4) = '1' and instructuion(3 downto 0) = X"E" else
								 active_high_f   when instructuion(4) = '1' and instructuion(3 downto 0) = X"F" else
								 active_high_blank;

	--A large when else, that will grab for the second to the bottom hex
	hexOut(15 downto 8) <= active_high_0   when instructuion(12) = '1' and instructuion(11 downto 8) = X"0" else
								  active_high_1   when instructuion(12) = '1' and instructuion(11 downto 8) = X"1" else
								  active_high_2   when instructuion(12) = '1' and instructuion(11 downto 8) = X"2" else
								  active_high_3   when instructuion(12) = '1' and instructuion(11 downto 8) = X"3" else
								  active_high_4   when instructuion(12) = '1' and instructuion(11 downto 8) = X"4" else
								  active_high_5   when instructuion(12) = '1' and instructuion(11 downto 8) = X"5" else
								  active_high_6   when instructuion(12) = '1' and instructuion(11 downto 8) = X"6" else
								  active_high_7   when instructuion(12) = '1' and instructuion(11 downto 8) = X"7" else
								  active_high_8   when instructuion(12) = '1' and instructuion(11 downto 8) = X"8" else
								  active_high_9   when instructuion(12) = '1' and instructuion(11 downto 8) = X"9" else
								  active_high_a   when instructuion(12) = '1' and instructuion(11 downto 8) = X"A" else
								  active_high_b   when instructuion(12) = '1' and instructuion(11 downto 8) = X"B" else
								  active_high_c   when instructuion(12) = '1' and instructuion(11 downto 8) = X"C" else
								  active_high_d   when instructuion(12) = '1' and instructuion(11 downto 8) = X"D" else
								  active_high_e   when instructuion(12) = '1' and instructuion(11 downto 8) = X"E" else
								  active_high_f   when instructuion(12) = '1' and instructuion(11 downto 8) = X"F" else
								  active_high_blank;


	--A large when else, that will grab for the third hex
	hexOut(23 downto 16) <= active_high_0   when instructuion(20) = '1' and instructuion(19 downto 16) = X"0" else
								   active_high_1   when instructuion(20) = '1' and instructuion(19 downto 16) = X"1" else
								   active_high_2   when instructuion(20) = '1' and instructuion(19 downto 16) = X"2" else
								   active_high_3   when instructuion(20) = '1' and instructuion(19 downto 16) = X"3" else
								   active_high_4   when instructuion(20) = '1' and instructuion(19 downto 16) = X"4" else
								   active_high_5   when instructuion(20) = '1' and instructuion(19 downto 16) = X"5" else
								   active_high_6   when instructuion(20) = '1' and instructuion(19 downto 16) = X"6" else
								   active_high_7   when instructuion(20) = '1' and instructuion(19 downto 16) = X"7" else
								   active_high_8   when instructuion(20) = '1' and instructuion(19 downto 16) = X"8" else
								   active_high_9   when instructuion(20) = '1' and instructuion(19 downto 16) = X"9" else
								   active_high_a   when instructuion(20) = '1' and instructuion(19 downto 16) = X"A" else
								   active_high_b   when instructuion(20) = '1' and instructuion(19 downto 16) = X"B" else
								   active_high_c   when instructuion(20) = '1' and instructuion(19 downto 16) = X"C" else
								   active_high_d   when instructuion(20) = '1' and instructuion(19 downto 16) = X"D" else
								   active_high_e   when instructuion(20) = '1' and instructuion(19 downto 16) = X"E" else
								   active_high_f   when instructuion(20) = '1' and instructuion(19 downto 16) = X"F" else
								   active_high_blank;


	--A large when else, that will grab for the fourth hex
	hexOut(31 downto 24) <= active_high_0   when instructuion(28) = '1' and instructuion(27 downto 24) = X"0" else
								   active_high_1   when instructuion(28) = '1' and instructuion(27 downto 24) = X"1" else
								   active_high_2   when instructuion(28) = '1' and instructuion(27 downto 24) = X"2" else
								   active_high_3   when instructuion(28) = '1' and instructuion(27 downto 24) = X"3" else
								   active_high_4   when instructuion(28) = '1' and instructuion(27 downto 24) = X"4" else
								   active_high_5   when instructuion(28) = '1' and instructuion(27 downto 24) = X"5" else
								   active_high_6   when instructuion(28) = '1' and instructuion(27 downto 24) = X"6" else
								   active_high_7   when instructuion(28) = '1' and instructuion(27 downto 24) = X"7" else
								   active_high_8   when instructuion(28) = '1' and instructuion(27 downto 24) = X"8" else
								   active_high_9   when instructuion(28) = '1' and instructuion(27 downto 24) = X"9" else
								   active_high_a   when instructuion(28) = '1' and instructuion(27 downto 24) = X"A" else
								   active_high_b   when instructuion(28) = '1' and instructuion(27 downto 24) = X"B" else
								   active_high_c   when instructuion(28) = '1' and instructuion(27 downto 24) = X"C" else
								   active_high_d   when instructuion(28) = '1' and instructuion(27 downto 24) = X"D" else
								   active_high_e   when instructuion(28) = '1' and instructuion(27 downto 24) = X"E" else
								   active_high_f   when instructuion(28) = '1' and instructuion(27 downto 24) = X"F" else
								   active_high_blank;

end architecture BEHAVE;