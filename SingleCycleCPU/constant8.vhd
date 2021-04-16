-- ********************************************************
-- * project:     constant8
-- * filename:    constant8.vhd
-- * author:      rothn@msoe.edu
-- * date:        MSOE Spring Quarter 2020
-- * provides:    a constant number 8
-- ********************************************************

-- use library packages 
-- std_logic_1164: 9-valued logic signal voltages 
library ieee;
use ieee.std_logic_1164.all;

-- the number 8
entity constant8 is 
port(Y: out std_logic_vector(31 downto 0));
end entity constant8;

architecture dataflow of constant8 is
begin 

	Y <= X"00000008";

end architecture dataflow;