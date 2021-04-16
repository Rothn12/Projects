-- ******************************************************************
-- * project:	   scp-fpga
-- * filename:	   reg10.vhd
-- * author:	   rothn@msoe.edu
-- * date:	      MSOE Spring Quarter 2020
-- * provides:	   a 10-bit input, 32-bit output register 
-- ******************************************************************

-- use library packages
--  std_logic_1164: 9-valued logic signal voltages 
--  std_logic_numeric_std: allows arithmetic on std_logic_vectors 
library ieee;
use ieee.std_logic_1164.all;


-- function block symbol
-- inputs: 
--    D     : 10-bit input bus
--    LD    : active-low synchronous load control signal
--    RST   : active-low asynchronous reset signal
--    CLK   : clock for synchronized register behavior 
-- outputs: 
--    Q     : 32-bit output, upper 22 bits are zeros
entity REG10 is 
port(D   : in std_logic_vector(9 downto 0); 
     LD  : in std_logic;
     RST : in std_logic;
     CLK : in std_logic;
     Q   : out std_logic_vector(31 downto 0));
end entity REG10;

-- circuit description 
architecture BEHAVIORAL of REG10 is 
begin 

  reg: process(LD, RST, CLK)
  begin 
    if RST = '0' then Q <= X"00000000"; -- asynchronous reset
    elsif rising_edge(CLK) then    -- rising edge triggered sample
      if LD = '0' then     -- active-low load
         Q(31 downto 10) <= (others => '0'); -- all bits 0;
         Q(9 downto 0) <= D; 
      end if;
    end if;
  end process;

end architecture BEHAVIORAL;