-- ********************************************************
-- * project: control
-- * filename: control.vhd
-- * author: << insert your name here >>
-- * date: MSOE Spring Quarter 2020
-- * provides: a control circuit for the ARMv4 ISA
-- * instructions implemented in the CE1921
-- * single-cycle processor
-- * approach: use when-else statements
-- ********************************************************
-- use library packages
-- std_logic_1164: 9-valued logic signal voltages
library ieee;
use ieee.std_logic_1164.all;

-- functional block symbol
-- inputs
-- IBUS is the upper 12-bits of the 32-bit machine code
-- Z is the zero condition code flag from the CPSR
-- outputs
-- PCSRC: 0 = BranchAddress 1 = PC+4
-- A2SRC: 0 = Rm 1 = Rd
-- REGWR: 0 = Regfile Write 1 = Regfile does not write
-- ALUSRCB: 0 = imm32 1 = RD2 from Regfile
-- ALUS: 0 = ADD 1 = SUb
-- 2 = AND 3 = OR
-- 4 = XOR 5 = A
-- 6 = B 7 = 0X00000001
-- CSPRWR: 0 = CPSR Write 1 = CPSR does not write
-- MEMWR: 0 = Data Mem Write 1 = Data Mem does not write
-- REGSRC: 0 = Data Mem Value 1 = ALU Value
entity CONTROL is
port(IBUS: in std_logic_vector(31 downto 20);
	  Z: in std_logic;
 	  PCSRC: out std_logic;
 	  A2SRC: out std_logic;
	  REGWR: out std_logic;
 	  ALUSRCB: out std_logic;
 	  ALUS: out std_logic_vector(2 downto 0);
 	  CPSRWR: out std_logic;
 	  MEMWR: out std_logic;
	  MEMRD: out std_logic;
 	  REGSRC: out std_logic);
end entity CONTROL;

-- circuit description
architecture DATAFLOW of CONTROL is
 	  -- declare signals for the IBUS bit fields
 	  -- data processing
 	  signal COND : std_logic_vector(3 downto 0);
 	  signal OPCODE: std_logic_vector(1 downto 0);
 	  signal I: std_logic;
 	  signal CMD: std_logic_vector(3 downto 0);
	  signal S: std_logic;
 	  -- load-store
	  signal IBAR: std_logic;
 	  signal PUBW: std_logic_vector(3 downto 0);
 	  signal L: std_logic;
 	  -- branch
 	  signal BRL: std_logic; -- the branch L bit is a different bit than Load/Store L

begin

	  -- assign IBUS bits to internal signals
 	  COND <= IBUS(31 downto 28);
 	  OPCODE <= IBUS(27 downto 26);
	  
	  --processing
 	  I <= IBUS(25);
	  CMD <= IBUS(24 downto 21);
	  s <= IBUS(20);
	  
	  --load/store
	  IBAR <= IBUS(25);
	  PUBW <= IBUS(24 downto 21);
	  L <= IBUS(20); 
	  
	  --branch
	  BRL <= IBUS(24);

 	  -- write output equations using when-else syntax
 	  -- include rows from data processing, load-store, and branch truth tables
 	  PCSRC <= '0' when COND=X"0" and OPCODE=B"10" and BRL='0' and Z='1' else -- beq taking branch
				  '0' when COND=x"E" and OPCODE=B"10" and (BRL='0' or BRL='1') and z='0' else -- bne taking branch
				  '0' when COND=x"1" and OPCODE=B"10" and BRL='0' AND z='0' else -- bne taking branch
				  '1'; -- PC+4 for all other instructions

 	  A2SRC <= '1' when COND=x"E" and OPCODE=B"01" and IBAR='0' and PUBW=x"C" and L='0' else --str taking rd
				  '0';

	  REGWR <= '1' when COND=x"E" and OPCODE=B"00" and (I='0' or I ='1') and CMD=x"A" and s='1' else --cmp taking 1
				  '1' when COND=x"E" and OPCODE=B"01" and IBAR ='0' and PUBW=x"C" and L='0' else -- str taking 1
				  '1' when COND=x"E" and OPCODE=B"10" and BRL='0' and (z='0' or z='1') else -- b taking 1
				  '1' when COND=x"0" and OPCODE=B"10" and BRL='0' and (z='0' or z='1') else -- beq taking 1
				  '1' when COND=x"1" and OPCODE=B"10" and BRL='0' and (z='0' or z='1') else -- bne taking 1
				  '0';
	  ALUSRCB <= '1' when COND=x"E" and OPCODE=B"00" and I='0' and CMD=x"4" and s='0' else -- add taking 1
					 '1' when COND=x"E" and OPCODE=B"00" and I='0' and CMD=x"0" and s='0' else -- and taking 1
					 '1' when COND=x"E" and OPCODE=B"00" and I='0' and CMD=x"A" and s='1' else -- cmp taking 1
					 '1' when COND=x"E" and OPCODE=B"00" and I='0' and CMD=x"1" and s='0' else -- eor taking 1
					 '1' when COND=x"E" and OPCODE=B"00" and I='0' and CMD=x"D" and s='0' else -- mov taking 1
					 '1' when COND=x"E" and OPCODE=B"00" and I='0' and CMD=x"C" and s='0' else -- orr taking 1
					 '1' when COND=x"E" and OPCODE=B"00" and I='0' and CMD=x"2" and s='0' else -- sub taking 1
					 '0';
					 
	  ALUS <= B"010" when COND=x"E" and OPCODE=B"00" and (I='0' or I ='1') and CMD=x"0" and s='0' else -- and, and imm taking 2
				 B"001" when COND=x"E" and OPCODE=B"00" and (I='0' or I ='1') and CMD=x"A" and s='1' else -- cmp, cmp imm  taking 1
				 B"100" when COND=x"E" and OPCODE=B"00" and (I='0' or I ='1') and CMD=x"1" and s='0' else -- eor, eor imm  taking 4
				 B"110" when COND=x"E" and OPCODE=B"00" and (I='0' or I ='1') and CMD=x"D" and s='0' else -- mov, mov imm  taking 6
				 B"011" when COND=x"E" and OPCODE=B"00" and (I='0' or I ='1') and CMD=x"C" and s='0' else -- orr, orr imm  taking 3
				 B"001" when COND=x"E" and OPCODE=B"00" and (I='0' or I ='1') and CMD=x"2" and s='0' else -- sub, sub imm  taking 1
				 B"000";
				 
	 CPSRWR <= '0' when COND=x"E" and OPCODE=B"00" and CMD=x"A" and s='1' else -- cmp, cmp imm taking 0
				  '1';
				  
	 MEMWR <= '0' when COND=x"E" and OPCODE=B"01" and IBAR='0' and PUBW=x"C" and L='0' else -- str taking 0
				 '1';
				 
	 REGSRC <= '1' when COND=x"E" and OPCODE=B"00" and (I='0' or I ='1') and CMD=x"4" and s='0' else -- add, add imm taking 1
				  '1' when COND=x"E" and OPCODE=B"00" and (I='0' or I ='1') and CMD=x"0" and s='0' else -- and, and imm taking 1
				  '1' when COND=x"E" and OPCODE=B"00" and (I='0' or I ='1') and CMD=x"1" and s='0' else -- eor, eor imm taking 1
				  '1' when COND=x"E" and OPCODE=B"00" and (I='0' or I ='1') and CMD=x"D" and s='0' else -- mov, mov imm taking 1
				  '1' when COND=x"E" and OPCODE=B"00" and (I='0' or I ='1') and CMD=x"C" and s='0' else -- orr, orr imm taking 1
				  '1' when COND=x"E" and OPCODE=B"00" and (I='0' or I ='1') and CMD=x"2" and s='0' else -- sub, sub imm taking 1
				  '0'; 
				  
	 MEMRD <= '0' when COND=x"E" and OPCODE=B"01" and IBAR='0' and PUBW=x"C" and L='1' else 
			    '1';

end architecture DATAFLOW; 