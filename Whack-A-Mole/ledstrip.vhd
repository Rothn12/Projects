library ieee; 
use ieee.std_logic_1164.all;

package ledstrip is

	--Leds
	constant active_high_bit9 : std_logic_vector(9 downto 0) := B"1000000000";
	constant active_high_bit8 : std_logic_vector(9 downto 0) := B"0100000000";
	constant active_high_bit7 : std_logic_vector(9 downto 0) := B"0010000000";
	constant active_high_bit6 : std_logic_vector(9 downto 0) := B"0001000000";
	constant active_high_bit5 : std_logic_vector(9 downto 0) := B"0000100000";
	constant active_high_bit4 : std_logic_vector(9 downto 0) := B"0000010000";
	constant active_high_bit3 : std_logic_vector(9 downto 0) := B"0000001000";
	constant active_high_bit2 : std_logic_vector(9 downto 0) := B"0000000100";
	constant active_high_bit1 : std_logic_vector(9 downto 0) := B"0000000010";
	constant active_high_bit0 : std_logic_vector(9 downto 0) := B"0000000001";
	constant active_high_blank : std_logic_vector(9 downto 0) := B"0000000000";
	
	-- Switches 
	constant active_high_sw9 : std_logic_vector(9 downto 0) := B"1000000000";
	constant active_high_sw8 : std_logic_vector(9 downto 0) := B"0100000000";
	constant active_high_sw7 : std_logic_vector(9 downto 0) := B"0010000000";
	constant active_high_sw6 : std_logic_vector(9 downto 0) := B"0001000000";
	constant active_high_sw5 : std_logic_vector(9 downto 0) := B"0000100000";
	constant active_high_sw4 : std_logic_vector(9 downto 0) := B"0000010000";
	constant active_high_sw3 : std_logic_vector(9 downto 0) := B"0000001000";
	constant active_high_sw2 : std_logic_vector(9 downto 0) := B"0000000100";
	constant active_high_sw1 : std_logic_vector(9 downto 0) := B"0000000010";
	constant active_high_sw0 : std_logic_vector(9 downto 0) := B"0000000001";
	constant active_high_Nosw : std_logic_vector(9 downto 0) := B"0000000000";
	

end package ledstrip;