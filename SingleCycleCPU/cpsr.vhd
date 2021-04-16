-- ********************************************************
-- * project:     cpsr
-- * filename:    cpsr.vhd
-- * author:      rothn@msoe.edu
-- * date:        MSOE Spring Quarter 2020
-- * provides:    adds two numbers that are input
-- ********************************************************

-- use library packages 
-- std_logic_1164: 9-valued logic signal voltages 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- A: the first input
-- B: the second input
-- S: the output
entity cpsr is 
port(D3, D2, D1, D0: in std_logic;
	  LD, RST, CLK: in std_logic;
	  Q3, Q2, Q1, Q0: out std_logic);
end entity cpsr;

architecture dataflow of cpsr is
begin 

  -- q3 reg
  q3reg: process(all) 
	begin
		if RST = '0' then Q3 <= '0';
		elsif rising_edge(CLK) then 
			if LD = '0' then Q3 <= D3;
			end if;
		end if;
	end process q3reg;
	
  -- q2 reg
  q2reg: process(all) 
	begin
		if RST = '0' then Q2 <= '0';
		elsif rising_edge(CLK) then 
			if LD = '0' then Q2 <= D2;
			end if;
		end if;
	end process q2reg;
	
  -- q1 reg
  q1reg: process(all) 
	begin
		if RST = '0' then Q1 <= '0';
		elsif rising_edge(CLK) then 
			if LD = '0' then Q1 <= D1;
			end if;
		end if;
	end process q1reg;
	
  -- q0 reg
  q0reg: process(all) 
	begin
		if RST = '0' then Q0 <= '0';
		elsif rising_edge(CLK) then 
			if LD = '0' then Q0 <= D0;
			end if;
		end if;
	end process q0reg;

end architecture dataflow;