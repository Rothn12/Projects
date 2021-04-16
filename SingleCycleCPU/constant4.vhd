-- ********************************************************
-- * project:     constant4
-- * filename:    constant4.vhd
-- * author:      rothn@msoe.edu
-- * date:        MSOE Spring Quarter 2020
-- * provides:    a constant number 4
-- ********************************************************

-- use library packages 
-- std_logic_1164: 9-valued logic signal voltages 
library ieee;
use ieee.std_logic_1164.all;

-- the number 4
entity constant4 is 
port(Y: out std_logic_vector(31 downto 0));
end entity constant4;

architecture dataflow of constant4 is
begin 

	Y <= X"00000004";

end architecture dataflow;