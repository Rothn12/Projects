-- ********************************************************
-- * project:     rotator
-- * filename:    rotator.vhd
-- * author:      rothn@msoe.edu
-- * date:        MSOE Spring Quarter 2020
-- * provides:    a component to right rotate a 32-bit 
-- *              number a specified number of 2-bit 
-- *              rotations
-- * approach:    use a multiplexer to route bits
-- ********************************************************

-- use library packages 
-- std_logic_1164: 9-valued logic signal voltages 
library ieee;
use ieee.std_logic_1164.all;

-- function block symbol 
-- NUM is the input 32-bit number
-- ROT4 is a 4-bit number encoding the number of 2-bit right rotates
-- B is the rotated output for use by the ALU
entity ROTATOR is 
port(NUM:  in std_logic_vector(31 downto 0);
     ROT:  in std_logic_vector(3 downto 0);
     B: out std_logic_vector(31 downto 0));
end entity ROTATOR;

-- circuit description 
architecture MULTIPLEXER of ROTATOR is 
begin

   -- Rotator 
   with ROT select 
        -- rotate right 15 two-bit rotations 
   B <= NUM(29 downto 0)&B"00" when B"1111",
        -- rotate right 14 two-bit rotations
        NUM(27 downto 0)&B"0000" when B"1110", 
		  -- rotate right 13 two-bit rotations
        NUM(25 downto 0)&B"000000" when B"1101",
		 -- rotate right 12 two-bit rotations
        NUM(23 downto 0)&B"00000000" when B"1100",  
        -- rotate right 11 two-bit rotations
        NUM(21 downto 0)&B"0000000000" when B"1011",  
		  -- rotate right 10 two-bit rotations
        NUM(19 downto 0)&B"000000000000" when B"1010", 
		  -- rotate right 9 two-bit rotations
        NUM(17 downto 0)&B"00000000000000" when B"1001", 
		  -- rotate right 8 two-bit rotations
        NUM(15 downto 0)&B"0000000000000000" when B"1000", 
		  -- rotate right 7 two-bit rotations
        NUM(13 downto 0)&B"000000000000000000" when B"0111", 
		  -- rotate right 6 two-bit rotations
        NUM(11 downto 0)&B"00000000000000000000" when B"0110", 
		  -- rotate right 5 two-bit rotations
        NUM(9 downto 0)&B"0000000000000000000000" when B"0101",
		  -- rotate right 4 two-bit rotations
        NUM(7 downto 0)&B"000000000000000000000000" when B"0100",         
        -- rotate right 3 two-bit rotations
        NUM(5 downto 0)&B"000000000000000000000000"&NUM(7 downto 6) when B"0011", 
		  -- rotate right 2 two-bit rotations
        NUM(3 downto 0)&B"000000000000000000000000"&NUM(7 downto 4) when B"0010", 
		  -- rotate right 1 two-bit rotations
        NUM(1 downto 0)&B"000000000000000000000000"&NUM(7 downto 2) when B"0001", 
        -- rotate right zero two-bit rotations
        NUM when others;  
        
 end architecture MULTIPLEXER;