-- *********************************************************************
-- * project:	   scp-fpga
-- * filename:	   addressdecoder.vhd
-- * author:	   rothn@msoe.edu
-- * date:	      MSOE Spring Quarter 2020
-- * provides:	   a system level address decoder for the CE1921 computer
-- *********************************************************************

-- use library packages
--  std_logic_1164: 9-valued logic signal voltages 
--  std_logic_numeric_std: allows arithmetic on std_logic_vectors 
library ieee;
use ieee.std_logic_1164.all;


-- function block symbol
-- inputs: 
--    ADDR  : 32-bit memory address output by the processor
--    MEMRD : control signal from processor controller 
--    MEMWR : control signal from processor controller
-- outputs: 
--    LD2   : active-low output requesting data memory load
--    LD1   : active-low output requesting LED device load 
--    LD0   : active-low output requesting SEG7 device load
--    DATAS : select signal for system level input data multiplexer 
entity ADDRESSDECODER is 
port(ADDR: in std_logic_vector(31 downto 0);
     MEMRD : in std_logic;
     MEMWR : in std_logic;
     LD2   : out std_logic;
     LD1   : out std_logic;
     LD0   : out std_logic;
     DATAS : out std_logic);
end entity ADDRESSDECODER;

-- circuit description 
-- hint: use truth table in Table 2 of lab assignment 
architecture DATAFLOW of ADDRESSDECODER is 
begin 

  LD2 <= '0' when ADDR < X"0000001F" and MEMRD = '1' and MEMWR = '0' else -- STR to MEM addresses
         '1'; -- all others
        
  LD1 <= '0' when ADDR=X"000000F8" and MEMRD='1' and MEMWR='0' else
	      '1'; 
        
  LD0 <= '0' when ADDR=X"000000FC" and MEMRD='1' and MEMWR='0' else 
			'1';
         
  DATAS <= '1' when ADDR < X"0000001F" and MEMRD='0' and MEMWR='1' else 
			  '0';

end architecture DATAFLOW;