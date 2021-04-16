-- ********************************************************
-- * project:     adder
-- * filename:    adder.vhd
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
entity adder is 
port(A, B: in std_logic_vector(31 downto 0);
	  S: out std_logic_vector(31 downto 0));
end entity adder;

architecture dataflow of adder is
begin 

	S <= A + B;

end architecture dataflow;