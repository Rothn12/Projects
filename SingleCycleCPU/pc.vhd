-- ********************************************************
-- * project:     pc
-- * filename:    pc.vhd
-- * author:      rothn@msoe.edu
-- * date:        MSOE Spring Quarter 2020
-- * provides:    Program counter
-- ********************************************************

-- use library packages 
-- std_logic_1164: 9-valued logic signal voltages 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- D: the input number
-- Q: the output number
-- LD: the load signal
-- RST: the reset signal
-- CLK: the clock signal
entity pc is 
port(D: in std_logic_vector(31 downto 0);
	  LD, RST, CLK: in std_logic;
	  Q: out std_logic_vector(31 downto 0));
end entity pc;

architecture dataflow of pc is
begin 

  -- Pc reg
  pc: process(all) 
	begin
		if RST = '0' then Q <= X"00000000";
		elsif rising_edge(CLK) then 
			if LD = '0' then Q <= D;
			end if;
		end if;
	end process pc;

end architecture dataflow;