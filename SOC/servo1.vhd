library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity servo1 is
port(data 	  : in std_logic_vector(7 downto 0);
	  clk 	  : in std_logic;
	  servoOut : out std_logic);
end entity servo1;

architecture BEHAV of servo1 is
   -- declare other internal signals for 1MHz clock
  signal cnt: integer range 0 to 500001;
  
  signal high_count: integer range 0 to 113750;
  
  signal too_big: std_logic;

 begin
  
  too_big <= '0' when data > X"C8" else '1';
  
  
  high_count <= (50000 + (to_integer(unsigned(data)))*250) when too_big = '1' else 0;

	-- clock process
	slow_clock: process(all)
	begin
		if rising_edge(clk) then
			cnt <= cnt+1;
			--make the clock speed 1MHz
			if high_count < 100001 then 
				if cnt = 500000 then
					cnt <= 0; 
				elsif cnt > high_count then
					servoOut <= '0';
				else 
					servoOut <= '1';
				end if;
			else 
				servoOut <= '0';
			end if;
		end if;
	end process;
	
	
	
end architecture BEHAV;