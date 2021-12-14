/*
*  Project:   Wack-a-mole
*  Entity:    wack
*  Author:    rothn@msoe.edu
*  Date:      27 JAN 2020
*  Purpose:  
*      To create a circuit that plays wack-a-mole on a
*      DE-10 LITE board. The game will have 21 possible
*      states, allowing two players to play. The first will
*      go for 9 states, a point is scored when the user 
*	    flips the switch underneth the lit led when it
*      activates. After player one, the second player
*		 will go for 9 states and the winner will be 
*      displayed on the seven-segment displayed
*/

-- library 
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.dseg7.all;
use work.ledstrip.all;
use work.clockdiv.all;


-- entity description
entity wack is
port(rst, clk: in std_logic;
     switches: in std_logic_vector(9 downto 0);
	  leds: out std_logic_vector(9 downto 0);
	  hex5: out std_logic_vector(7 downto 0);
	  hex4: out std_logic_vector(7 downto 0);
	  hex3: out std_logic_vector(7 downto 0);
	  hex2: out std_logic_vector(7 downto 0);
	  hex1: out std_logic_vector(7 downto 0);
	  hex0: out std_logic_vector(7 downto 0));
end entity wack;


-- architecture description
architecture behavioral of wack is

  -- internal state counter
  signal q,d : integer range 0 to 39;
  
  -- player load and counter internal signals
  signal p1ld, p2ld: std_logic;
  signal p1scrd, p1scrq, p2scrd, p2scrq: integer range 0 to 9;
  
  -- random ld
  signal randld: integer range 0 to 1;
  signal less_slow_clk: std_logic; 
  signal cnt2: integer range 0 to 25000000;
  signal rndCNT: std_logic_vector (25 downto 0);
  signal sq, sd: integer range 0 to 3;
  signal rnd_slow: std_logic;
  
  -- if the led should light up
  signal ledlight: integer range 0 to 10;
  
  -- declare other internal signals for 1-Hz clock
  signal slow_clk: std_logic;
  signal cnt: integer range 0 to 25000000;
  
  -- random counter signals
  signal rndmcount, randomreg: integer range 0 to 9;

  -- assign DE10-Lite pins 
  -- see DE10-Lite Manual pages 24 - 29 for pins
  attribute chip_pin : string;
  attribute chip_pin of rst : signal is "A7"; -- key0
  attribute chip_pin of clk : signal is "P11";
  attribute chip_pin of leds : signal is
    "B11,A11,D14,E14,C13,D13,B10,A10,A9,A8 ";
  attribute chip_pin of switches: signal is
    "F15,B14,A14,A13,B12,A12,C12,D12,C11,C10";
  attribute chip_pin of hex5 : signal is 
    "L19,N20,N19,M20,N18,L18,K20,J20";
  attribute chip_pin of hex4 : signal is 
    "F17,F20,F19,H19,J18,E19,E20,F18";
  attribute chip_pin of hex3 : signal is 
    "D22,E17,D19,C20,C19,E21,E22,F21"; 
  attribute chip_pin of hex2 : signal is 
    "A19,B22,C22,B21,A21,B19,A20,B20";
  attribute chip_pin of hex1 : signal is 
    "A16,B17,A18,A17,B16,E18,D18,C18";
  attribute chip_pin of hex0 : signal is 
    "D15,C17,D17,E16,C16,C15,E15,C14";
	 

begin

  -- next state logic states
  d <= q+1 when q<39 else 0;
  
  
  -- next state logic player 1 score
  p1scrd <= p1scrq+1 when p1scrq < 9 else 9;				
  
  -- next state logic player 2 score
  p2scrd <= p2scrq+1 when p2scrq < 9 else 9; 
  
  
  	--register for states
	reg: process(all) -- uses all inputs could possible affect the process
	begin
		if rising_edge(slow_clk) then 
			if rst = '0' then q <= 0;
			else q <= d;
			end if;
		end if;
	end process reg;
  
  
  -- Player 1 score
  p1: process(all) -- uses all inputs could possible affect the process
	begin
		if rising_edge(less_slow_clk) then 
			if rst = '0' then p1scrq <= 0;
				elsif p1ld = '1' then p1scrq <= p1scrd;
				elsif q = 0 then p1scrq <= 0;
			end if;
		end if;
	end process p1;
	  
  -- Player 2 score
  p2: process(all) -- uses all inputs could possible affect the process
	begin
		if rising_edge(less_slow_clk) then 
			if rst = '0' then p2scrq <= 0;
				elsif p2ld = '1' then p2scrq <= p2scrd;
				elsif q = 0 then p2scrq <= 0;
			end if;
		end if;
	end process p2;

	
  -- load signal for the random number		
  randomLD: process(all)
  begin
	if rising_edge(rnd_slow) then 
		if rst = '0' then randld <= 0;
			elsif randld = 0 then randld <= 1;
		   else randld <= 0;
		end if;
	end if;
  end process randomLD;
				  
	
  -- random counter 
  rndm:process(all) 
  begin   
    if rising_edge(clk) then  
		 if rst = '0' then rndmcount <= 0; 
			elsif rndmcount = 9 then rndmcount <= 0;
				else rndmcount <= rndmcount + 1;  
		  end if;
    end if;
  end process rndm;	

	-- process that grabs the random number when told by the go signal
	-- note that humans are slow; if a fast clock is attached, this process will literally get 
	-- random values millions of times before the load is  1. Thus, the random number is really
	-- captured when the load signal is 1
  getrandom:process(all) 
  begin	
    if rising_edge(less_slow_clk) then 
      if randld = 1 then randomreg <= rndmcount; 
		end if;
    end if;	
  end process;
  
  
  -- multiplexer to check the leds should light up
  with q select 
  ledlight <= randomreg when 16 to 24 | 28 to 36,
	           10 when others;
  
  
  -- output logic for random number
  with ledlight select 
  leds <= active_high_bit0 when 0,
		    active_high_bit1 when 1,
			 active_high_bit2 when 2,
			 active_high_bit3 when 3,
		    active_high_bit4 when 4,
			 active_high_bit5 when 5,
			 active_high_bit6 when 6,
		    active_high_bit7 when 7,
			 active_high_bit8 when 8,
			 active_high_bit9 when 9,
			 active_high_blank when others;

			 
	-- p1 enable score enable
	p1ld <= '1' when leds = active_high_bit0 and switches = active_high_sw0 and q > 15 and q < 25 else 
	        '1' when leds = active_high_bit1 and switches = active_high_sw1 and q > 15 and q < 25 else 
			  '1' when leds = active_high_bit2 and switches = active_high_sw2 and q > 15 and q < 25 else 
			  '1' when leds = active_high_bit3 and switches = active_high_sw3 and q > 15 and q < 25 else 
			  '1' when leds = active_high_bit4 and switches = active_high_sw4 and q > 15 and q < 25 else 
			  '1' when leds = active_high_bit5 and switches = active_high_sw5 and q > 15 and q < 25 else 
			  '1' when leds = active_high_bit6 and switches = active_high_sw6 and q > 15 and q < 25 else 
			  '1' when leds = active_high_bit7 and switches = active_high_sw7 and q > 15 and q < 25 else 
			  '1' when leds = active_high_bit8 and switches = active_high_sw8 and q > 15 and q < 25 else 
			  '1' when leds = active_high_bit9 and switches = active_high_sw9 and q > 15 and q < 25 else 
			  '0';
			  
			  
	-- p2 enable score enable
	p2ld <= '1' when leds = active_high_bit0 and switches = active_high_sw0 and q > 27 and q < 37 else
	        '1' when leds = active_high_bit1 and switches = active_high_sw1 and q > 27 and q < 37 else
			  '1' when leds = active_high_bit2 and switches = active_high_sw2 and q > 27 and q < 37 else
			  '1' when leds = active_high_bit3 and switches = active_high_sw3 and q > 27 and q < 37 else
			  '1' when leds = active_high_bit4 and switches = active_high_sw4 and q > 27 and q < 37 else
			  '1' when leds = active_high_bit5 and switches = active_high_sw5 and q > 27 and q < 37 else
			  '1' when leds = active_high_bit6 and switches = active_high_sw6 and q > 27 and q < 37 else
			  '1' when leds = active_high_bit7 and switches = active_high_sw7 and q > 27 and q < 37 else
			  '1' when leds = active_high_bit8 and switches = active_high_sw8 and q > 27 and q < 37 else
			  '1' when leds = active_high_bit9 and switches = active_high_sw9 and q > 27 and q < 37 else
			  '0';
			 

			 
	-- output logic 
	hex0 <= active_low_m when q = 0 else
		     active_low_w when q = 1 else
			  active_low_dash when q = 2 else
			  active_low_f when q = 3 else
			  active_low_h when q = 4 else
			  active_low_t when q = 5 else
			  active_low_d when q = 6 else
			  active_low_e when q = 7 else
			  active_low_L when q = 8 else
			  active_low_blank when q = 9 else
			  active_low_blank when q = 10 else
			  active_low_y when q = 11 else
			  active_low_y when q = 12 else
			  active_low_y when q = 13 else
			  active_low_y when q = 14 else
			  active_low_y when q = 15 else
			  active_low_y when q = 25 else 
			  active_low_y when q = 26 else
			  active_low_y when q = 27 else 
			  active_low_0 when q > 15 and q < 25 and p1scrq = 0 else
			  active_low_1 when q > 15 and q < 25 and p1scrq = 1 else
			  active_low_2 when q > 15 and q < 25 and p1scrq = 2 else
			  active_low_3 when q > 15 and q < 25 and p1scrq = 3 else
			  active_low_4 when q > 15 and q < 25 and p1scrq = 4 else
			  active_low_5 when q > 15 and q < 25 and p1scrq = 5 else
			  active_low_6 when q > 15 and q < 25 and p1scrq = 6 else
			  active_low_7 when q > 15 and q < 25 and p1scrq = 7 else
			  active_low_8 when q > 15 and q < 25 and p1scrq = 8 else
			  active_low_9 when q > 15 and q < 25 and p1scrq = 9 else
			  active_low_0 when q > 27 and q < 37 and p2scrq = 0 else
			  active_low_1 when q > 27 and q < 37 and p2scrq = 1 else
			  active_low_2 when q > 27 and q < 37 and p2scrq = 2 else
			  active_low_3 when q > 27 and q < 37 and p2scrq = 3 else
			  active_low_4 when q > 27 and q < 37 and p2scrq = 4 else
			  active_low_5 when q > 27 and q < 37 and p2scrq = 5 else
			  active_low_6 when q > 27 and q < 37 and p2scrq = 6 else
			  active_low_7 when q > 27 and q < 37 and p2scrq = 7 else
			  active_low_8 when q > 27 and q < 37 and p2scrq = 8 else
			  active_low_9 when q > 27 and q < 37 and p2scrq = 9 else
			  active_low_0 when q > 36 and q < 40 and p2scrq = 0 else
			  active_low_1 when q > 36 and q < 40 and p2scrq = 1 else
			  active_low_2 when q > 36 and q < 40 and p2scrq = 2 else
			  active_low_3 when q > 36 and q < 40 and p2scrq = 3 else
			  active_low_4 when q > 36 and q < 40 and p2scrq = 4 else
			  active_low_5 when q > 36 and q < 40 and p2scrq = 5 else
			  active_low_6 when q > 36 and q < 40 and p2scrq = 6 else
			  active_low_7 when q > 36 and q < 40 and p2scrq = 7 else
			  active_low_8 when q > 36 and q < 40 and p2scrq = 8 else
			  active_low_9 when q > 36 and q < 40 and p2scrq = 9 else 
			  active_low_blank;
	-- output logic 
	hex1 <= active_low_o when q = 0 else
		     active_low_blank when q = 1 else
			  active_low_a when q = 2 else
			  active_low_blank when q = 3 else
			  active_low_t when q = 4 else
			  active_low_i when q = 5 else
			  active_low_n when q = 6 else
			  active_low_h when q = 7 else
			  active_low_blank when q = 8 else
			  active_low_o when q = 9 else
			  active_low_ed when q = 10 else
			  active_low_d when q = 11 else
			  active_low_d when q = 12 else
			  active_low_d when q = 13 else
			  active_low_d when q = 14 else
			  active_low_d when q = 15 else
			  active_low_d when q = 25 else
			  active_low_d when q = 26 else
			  active_low_d when q = 27 else
			  active_low_dash when q > 15 and q < 25 else
			  active_low_dash when q > 27 and q < 37 else
			  active_low_2 when q > 36 and q < 40 else 
			  active_low_blank;


	
	-- output logic 
	hex2 <= active_low_c when q = 0 else
		     active_low_o when q = 1 else
			  active_low_dash when q = 2 else
			  active_low_ed when q = 3 else
			  active_low_blank when q = 4 else
			  active_low_w when q = 5 else
			  active_low_u when q = 6 else
			  active_low_t when q = 7 else
			  active_low_t when q = 8 else
			  active_low_t when q = 9 else
			  active_low_r when q = 10 else
			  active_low_r when q = 11 else
			  active_low_r when q = 12 else
			  active_low_r when q = 13 else
			  active_low_r when q = 14 else
			  active_low_r when q = 15 else
	        active_low_r when q = 25 else
			  active_low_r when q = 26 else
			  active_low_r when q = 27 else
			  active_low_1 when q > 15 and q < 25 else
			  active_low_2 when q > 27 and q < 37 else
			  active_low_p when q > 36 and q < 40 else 
			  active_low_blank;
	   
	-- output logic 
	hex3 <= active_low_L when q = 0 else
		     active_low_t when q = 1 else
			  active_low_k when q = 2 else
			  active_low_L when q = 3 else
			  active_low_p when q = 4 else
			  active_low_s when q = 5 else
			  active_low_blank when q = 6 else
			  active_low_blank when q = 7 else
			  active_low_i when q = 8 else
			  active_low_blank when q = 9 else
			  active_low_c when q = 10 else
			  active_low_blank when q = 11 else
			  active_low_blank when q = 12 else
			  active_low_blank when q = 13 else
			  active_low_blank when q = 14 else
			  active_low_blank when q = 15 else
			  active_low_blank when q = 25 else
			  active_low_blank when q = 26 else
			  active_low_blank when q = 27 else
			  active_low_p when q > 15 and q < 25 else
			  active_low_p when q > 27 and q < 37 else
			  active_low_0 when q > 36 and q < 40 and p1scrq = 0 else
			  active_low_1 when q > 36 and q < 40 and p1scrq = 1 else
			  active_low_2 when q > 36 and q < 40 and p1scrq = 2 else
			  active_low_3 when q > 36 and q < 40 and p1scrq = 3 else
			  active_low_4 when q > 36 and q < 40 and p1scrq = 4 else
			  active_low_5 when q > 36 and q < 40 and p1scrq = 5 else
			  active_low_6 when q > 36 and q < 40 and p1scrq = 6 else
			  active_low_7 when q > 36 and q < 40 and p1scrq = 7 else
			  active_low_8 when q > 36 and q < 40 and p1scrq = 8 else
			  active_low_9 when q > 36 and q < 40 and p1scrq = 9 else 
			  active_low_blank;
			 
	
	-- output logic 
	hex4 <= active_low_e when q = 0 else
		     active_low_blank when q = 1 else
			  active_low_c when q = 2 else
			  active_low_o when q = 3 else
			  active_low_i when q = 4 else
			  active_low_blank when q = 5 else
			  active_low_h when q = 6 else
			  active_low_r when q = 7 else
			  active_low_L when q = 8 else
			  active_low_d when q = 9 else
			  active_low_c when q = 10 else
			  active_low_1 when q = 11 else
			  active_low_1 when q = 12 else
			  active_low_1 when q = 13 else
			  active_low_1 when q = 14 else
			  active_low_1 when q = 15 else
			  active_low_2 when q = 25 else
			  active_low_2 when q = 26 else
			  active_low_2 when q = 27 else
			  active_low_blank when q > 15 and q < 25 else
			  active_low_blank when q > 27 and q < 37 else
			  active_low_1 when q > 36 and q < 40 else 
			  active_low_blank;
	
	-- output logic 
	hex5 <= active_low_w when q = 0 else
		     active_low_e when q = 1 else
			  active_low_a when q = 2 else
			  active_low_m when q = 3 else
			  active_low_L when q = 4 else
			  active_low_e when q = 5 else
			  active_low_c when q = 6 else
			  active_low_e when q = 7 else
			  active_low_blank when q = 8 else
			  active_low_e when q = 9 else
			  active_low_s when q = 10 else
			  active_low_p when q = 11 else
			  active_low_p when q = 12 else
			  active_low_p when q = 13 else
			  active_low_p when q = 14 else
			  active_low_p when q = 15 else
			  active_low_p when q = 25 else
			  active_low_p when q = 26 else
			  active_low_p when q = 27 else
			  active_low_blank when q > 15 and q < 25 else
			  active_low_blank when q > 27 and q < 37 else
			  active_low_p when q > 36 and q < 40 else 
			  active_low_blank;
			  
  
  --selector for random clock
  sd <= sq+1 when sq < 3 else 0;
  
  -- random selector reg
  rndReg: process(all)
  begin
		if rising_edge(slow_clk) then sq <= sd;
		end if;
  end process rndReg;
  
  -- select output 
  with sq select 
  rnd_slow <= less_slow_clk when 3, 
              slow_clk when 2, 
				  less_slow_clk when 1, 
				  slow_clk when others;

	
	-- clock process
	slowTwo: process(all)
	begin
		if rising_edge(clk) then
				cnt2 <= cnt2+1;
			if cnt2 = clk2hz_value then
				less_slow_clk <= not less_slow_clk;
				cnt2 <= 0; 
			end if;
		end if;
	end process slowTwo; 
		 
			 
  	-- clock process
	counter: process(all)
	begin
		if rising_edge(clk) then
				cnt <= cnt+1;
			if cnt = clk1hz_value then
				slow_clk <= not slow_clk;
				cnt <= 0; 
			end if;
		end if;
	end process; 
  
end architecture behavioral;