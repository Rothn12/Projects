library ieee;
use ieee.std_logic_1164.all;

package clockdiv is

	constant crystal : integer := 50000000;
	constant clk1hz_value : integer := crystal/2;  -- 1 second clock
	constant clk2hz_value : integer := crystal/4;  -- 1/2 second clock
	constant clk3hz_value : integer := crystal/6;  -- 1/3 second clock
	constant clk4hz_value : integer := crystal/8;  -- 1/4 second clock
	constant clk8hz_value : integer := crystal/16;
	constant clk16hz_value : integer := crystal/32;
	
end package clockdiv;