-- ******************************************************************
-- * project:	   irom
-- * filename:	   irom.vhd
-- * author:	   rothn@msoe.edu 
-- * date:	      MSOE Spring Quarter 2020
-- * provides:	   an instruction ROM for the CE1921 processor
-- ******************************************************************

-- use library packages
--  std_logic_1164: 9-valued logic signal voltages 
library ieee;
use ieee.std_logic_1164.all;


-- function block symbol
-- inputs: 
--    ADDR  : 32-bit address requesting instruction 
-- outputs: 
--    Q     : 32-bit output of machine code instruction 
-- notes    : ROMs do not reset on power-up so no reset signal 
--          : ROMs do not load in user mode so no load signal  
entity IROM is 
port(ADDR  : in std_logic_vector(31 downto 0);
     Q     : out std_logic_vector(31 downto 0));
end entity IROM;

-- circuit description 
architecture MULTIPLEXER of IROM is 
begin

  -- use address to output correct binary machine code number 
  with ADDR select 
  Q <=    X"E3A0_4004" when X"00000000", --main:   MOV R4,#4       ; R4 = memory address
			 X"E3A0_C000" when X"00000004", --        MOV R12,#0      ; temp = 0
			 X"E584_C000" when X"00000008", --        STR R12,[R4]    ; MEM[4] = 0 : init memory
			 X"E3A0_C0F4" when X"0000000C", --        MOV R12,#SLIDE  ; address of sliders (.equ SLIDE,0x000000F4)
			 X"E59C_8000" when X"00000010", --        LDR R8,[R12]    ; i = n
			 X"E3A0_9000" when X"00000014", --        MOV R9,#0       ; sum = 0
			 X"E358_0000" when X"00000018", --        CMP R8,#0       ; i=0?
			 X"0A00_000A" when X"0000001C", --        BEQ print       ; if yes branch to print
			 X"E089_9008" when X"00000020", --loop:   ADD R9,R9,R8    ; sum = sum + i
			 X"E248_8001" when X"00000024", --        SUB R8,R8,#1    ; i = i - 1
			 X"E358_0000" when X"00000028", --        CMP R8,#0
			 X"1AFF_FFFB" when X"0000002C", --        BNE loop
			 X"E3A0_A000" when X"00000030", --if:     MOV R10,#0      ; creating FFFFFFE0
			 X"E24A_A020" when X"00000034", --        SUB R10,R10,#32 ; 0 - 32 = -32 = FFFFFFE0
			 X"E009_A00A" when X"00000038", --        AND R10,R9,R10
			 X"E35A_0000" when X"0000003C", --        CMP R10,#0
			 X"0A00_0000" when X"00000040", --        BEQ else        ; if (R9 > 32) MEM[4] = 1
			 X"E3A0_A001" when X"00000044", --        MOV R10,#1      ; set the 1
			 X"E584_A000" when X"00000048", --else:   STR R10,[R4]    ; memory[4] = either 1 or 0
			 X"E3A0_C0FC" when X"0000004C", --print:  MOV R12,#SEG7   ; seg7 data reg address (.equ SEG7,0x000000fc)
			 X"E58C_9000" when X"00000050", --        STR R9,[R12]    ; seg7 = sum
			 X"E3A9_C0F8" when X"00000054", --        MOV 12,#LED     ; LED reg address (.equ LED,0x000000F8)
			 X"E594_3000" when x"00000058", --        LDR R3,[R4]     ; get stored memory value back
			 X"E58C_3000" when x"0000005C", --        STR R3,[R12]    ; leds = mem[4] : is it >32? LED0 on
			 X"EAFF_FFFE" when others;      --done:   B done 
       
end architecture MULTIPLEXER;