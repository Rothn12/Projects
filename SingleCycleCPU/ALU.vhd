-- ******************************************************************
-- * project:	   alu
-- * filename:	   alu.vhd
-- * author:	   rothn@msoe.edu
-- * date:	      MSOE Spring Quarter 2020
-- * provides:	   32-bit ALU for the CE1921 single-cycle processor
-- ******************************************************************

-- use library packages
--  std_logic_1164: 9-valued logic signal voltages 
--  std_logic_numeric_std: allows arithmetic on std_logic_vectors 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


-- function block symbol
-- A, B, and F are 32-bit numbers 
-- signed and unsigned only matter when doing comparison 
-- the ALU doesn't do comparison so declaring as unsigned is fine  
entity ALU is 
port(A,B: in std_logic_vector(31 downto 0);
     S: in std_logic_vector(2 downto 0);
     F: out std_logic_vector(31 downto 0);
     C,V,N,Z: out std_logic);
end entity ALU;

-- circuit description 
architecture MULTIPLEXER of ALU is 

  -- 32-bit addition results in carry-out to column 32. 
  -- use 33-bit vectors to store that extra carry-out bit
  signal INTA, INTB, INTF: std_logic_vector(32 downto 0);

begin

  -- connect INTA and INTB to the inputs 
  INTA(32) <= '0';
  INTA(31 downto 0) <= A;
  INTB(32) <= '0';
  INTB(31 downto 0) <= B;
  
  -- complete the arithmetic and logic 
  with S select 
  INTF <= INTA+INTB when B"000", -- addition 
          INTA-INTB when B"001", -- subtraction 
			 INTA AND INTB when B"010", -- and A with B
			 INTA OR INTB when B"011", -- or A with B
			 INTA XOR INTB when B"100", -- XOR A with B
			 INTA when B"101", -- returns A
			 INTB when B"110", -- returns B
			 B"000000000000000000000000000000001" when others; -- returns 1
				
			 		 
  -- connect the 32-bit result to the output signal
  F <= INTF(31 downto 0);
  
  -- create the flag bits to announce particular result events
  C <= INTF(32); -- the carry out to column 32
   
  N <= '1' when INTF(31) = '1' else '0'; -- negative is just the MSB of the 32-bit result, that value gets returned
  
  Z <= '1' when INTF(31 downto 0) = X"00000000" else '0';
  
  V <= '1' when (S = B"000" AND INTA(31) = '0' AND INTB(31) = '0' AND INTF(31) = '1') else 
		 '1' when (S = B"000" AND INTA(31) = '1' AND INTB(31) = '1' AND INTF(31) = '0') else
		 '1' when (S = B"001" AND INTA(31) = '0' AND INTB(31) = '1' AND INTF(31) = '1') else 
		 '1' when (S = B"001" AND INTA(31) = '1' AND INTB(31) = '0' AND INTF(31) = '0') else 
		 '0';
  
  -- COMPLETE the truth table for signed overflow
  --   overflow occurs when two positives add to a negative 
  --   overflow occurs when two negatives add to a positive 
  --   overflow occurs when negative minus positive gives positive 
  --   overflow occurs when positive minus negative gives negative 
  --   remember that the sign bit of each number is is bit 31 
  --
  -- COMPLETE TRUTH TABLE BY FILLING IN VALUES FOR V 
  -- USING SELECT SIGNAL S(0) TO DIFFERENTIATE BETWEEN ADD AND SUBTRACT
  -- 
  -- S(0) INTA(31) INTB(31) INTF(31) | V   COMPLETE COMMENTS BEHIND V ALSO
  -- ------------------------------------
  -- 0    0        0        0        | 0   + plus + = +
  -- 0    0        0        1        | 1   + plus + = -
  -- 0    0        1        0        | 0   + plus - = + 
  -- 0    0        1        1        | 0   + plus - = -
  -- 0    1        0        0        | 0   - plus + = +
  -- 0    1        0        1        | 0   - plus + = -
  -- 0    1        1        0        | 1   - plus - = +
  -- 0    1        1        1        | 0   - plus - = -
  -- 
  -- 1    0        0        0        | 0   + minus + = +
  -- 1    0        0        1        | 0   + minus + = -
  -- 1    0        1        0        | 0   + minus - = + 
  -- 1    0        1        1        | 1   + minus - = -
  -- 1    1        0        0        | 1   - minus + = +
  -- 1    1        0        1        | 0   - minus + = -
  -- 1    1        1        0        | 0   - minus - = +
  -- 1    1        1        1        | 0   - minus - = -
  
  
  
end architecture MULTIPLEXER; 