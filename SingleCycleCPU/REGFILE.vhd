-- ******************************************************************
-- * project:	   regfile
-- * filename:	   regfile.vhd
-- * author:	   rothn@msoe.edu
-- * date:	      MSOE Spring Quarter 2020
-- * provides:	   a register file for the CE1921 processor
-- ******************************************************************

-- use library packages
--  std_logic_1164: 9-valued logic signal voltages 
--  std_logic_numeric_std: allows arithmetic on std_logic_vectors 
library ieee;
use ieee.std_logic_1164.all;


-- function block symbol
-- inputs: 
--    A1, A2: 4-bit addresses specifying output registers RD1 and RD2 
--    A3    : 4-bit address specifying register to write WD3 data to 
--    WD3   : 32-bit data to be stored in register addressed by A3 
--    REGWR : control signal to determine if input WD3 data gets stored 
--    RST   : active-low synchronous reset signal
--    CLK   : clock for synchronized register behavior 
-- outputs: 
--    RD1   : 32-bit output from register specified by address A1 
--    RD2   : 32-bit output from register specified by address A2 
entity REGFILE is 
port(A1    : in std_logic_vector(3 downto 0);
     A2    : in std_logic_vector(3 downto 0); 
	  A3	  : in std_logic_vector(3 downto 0);
	  WD3   : in std_logic_vector(31 downto 0);
	  REGWR : in std_logic;
	  RST   : in std_logic;
	  CLK   : in std_logic;
	  RD1   : out std_logic_vector(31 downto 0);
	  RD2   : out std_logic_vector(31 downto 0));     
end entity REGFILE;

-- circuit description 
architecture BEHAVIORAL of REGFILE is 
   -- internal signals that will become register outputs
   signal R0,R1,R2,R3,R4,R5,R6,R7,R8: std_logic_vector(31 downto 0); 
	signal R9,R10,R11,R12,R13,R14,R15: std_logic_vector(31 downto 0);     
  
begin

  -- use A1 and A2 to control with-select multiplexers for 
  -- outputs RD1 and RD2 
  with A1 select 
  RD1 <= R0  when B"0000", 
         R1  when B"0001", 
         R2  when B"0010", 
			R3  when B"0011",
			R4  when B"0100", 
         R5  when B"0101", 
         R6  when B"0110", 
			R7  when B"0111",
			R8  when B"1000", 
         R9  when B"1001", 
         R10 when B"1010", 
			R11 when B"1011",
			R12 when B"1100", 
         R13 when B"1101", 
         R14 when B"1110", 
         R15 when others; 
         
  with A2 select 
  RD2 <= R0  when B"0000", 
         R1  when B"0001", 
         R2  when B"0010", 
			R3  when B"0011",
			R4  when B"0100", 
         R5  when B"0101", 
         R6  when B"0110", 
			R7  when B"0111",
			R8  when B"1000", 
         R9  when B"1001", 
         R10 when B"1010", 
			R11 when B"1011",
			R12 when B"1100", 
         R13 when B"1101", 
         R14 when B"1110", 
         R15 when others; 
         
         
  -- implement sixteen registers with active-low synchronous reset 
  -- and active-low synchronous load when A3 specifies the register
  reg0: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R0 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"0000" then R0 <= WD3; 
        end if;
      end if;
    end if;
  end process;    
    
  reg1: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R1 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"0001" then R1 <= WD3; 
        end if;
      end if;
    end if;
  end process;
  
   reg2: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R2 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"0010" then R2 <= WD3; 
        end if;
      end if;
    end if;
  end process;    
    
  reg3: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R3 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"0011" then R3 <= WD3; 
        end if;
      end if;
    end if;
  end process;
  
    reg4: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R4 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"0100" then R4 <= WD3; 
        end if;
      end if;
    end if;
  end process;    
    
  reg5: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R5 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"0101" then R5 <= WD3; 
        end if;
      end if;
    end if;
  end process;
  
   reg6: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R6 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"0110" then R6 <= WD3; 
        end if;
      end if;
    end if;
  end process;    
    
  reg7: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R7 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"0111" then R7 <= WD3; 
        end if;
      end if;
    end if;
  end process;
  
    reg8: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R8 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"1000" then R8 <= WD3; 
        end if;
      end if;
    end if;
  end process;    
    
  reg9: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R9 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"1001" then R9 <= WD3; 
        end if;
      end if;
    end if;
  end process;
  
   reg10: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R10 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"1010" then R10 <= WD3; 
        end if;
      end if;
    end if;
  end process;    
    
  reg11: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R11 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"1011" then R11 <= WD3; 
        end if;
      end if;
    end if;
  end process;
  
    reg12: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R12 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"1100" then R12 <= WD3; 
        end if;
      end if;
    end if;
  end process;    
    
  reg13: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R13 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"1101" then R13 <= WD3; 
        end if;
      end if;
    end if;
  end process;
  
   reg14: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R14 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"1110" then R14 <= WD3; 
        end if;
      end if;
    end if;
  end process;    
    
  reg15: process(rst,clk) 
  begin 
    if rising_edge(clk) then 
      if RST = '0' then R15 <= X"00000000"; 
      elsif REGWR = '0' then 
        if A3 = B"1111" then R15 <= WD3; 
        end if;
      end if;
    end if;
  end process;
  
end architecture BEHAVIORAL;