library ieee;
use ieee.std_logic_1164.all;
use work.dseg7.all;

entity DE10_Lite_Computer is
port (
	--Clock pins
	CLOCK_50, CLOCK2_50, CLOCK_ADC_10 : in std_logic;

	-- ARDUINO
	ARDUINO_IO : inout std_logic_vector(15 downto 0);
	ARDUINO_RESET_N : inout std_logic;
	
	-- SDRAM
	DRAM_ADDR : out std_logic_vector(12 downto 0);
	DRAM_BA : out std_logic_vector(1 downto 0);
	DRAM_CAS_N : out std_logic;
	DRAM_CKE : out std_logic;
	DRAM_CLK : out std_logic;
	DRAM_CS_N : out std_logic;
	DRAM_DQ: inout std_logic_vector(15 downto 0);
	DRAM_LDQM : out std_logic;
	DRAM_RAS_N : out std_logic;
	DRAM_UDQM: out std_logic;
	DRAM_WE_N: out std_logic;

	-- Accelerometer
	G_SENSOR_CS_N : out std_logic;
	G_SENSOR_INT : in std_logic_vector(2 downto 1);
	G_SENSOR_SCLK : inout std_logic;
	G_SENSOR_SDI : inout std_logic;
	G_SENSOR_SDO : inout std_logic;
	
	-- forty pin headers
	GPIO : inout std_logic_vector(35 downto 0);

	-- Seven Segment Displays
	HEX0_3 : out std_logic_vector(31 downto 0);
	HEX4_5 : out std_logic_vector(15 downto 0);
	HEX0,HEX1,HEX2, HEX3, HEX4, HEX5 : out std_logic_vector(7 downto 0);

	-- Pushbuttons
	KEY : in std_logic_vector(1 downto 0);

	-- LEDs
	LEDR : out std_logic_vector(9 downto 0);

	-- Slider Switches
	SW : in std_logic_vector(9 downto 0);

	-- VGA
	VGA_B, VGA_G, VGA_R : out std_logic_vector(3 downto 0);
	VGA_HS, VGA_VS : out std_logic
	);

end entity DE10_Lite_Computer;


architecture STRUCTURAL of DE10_Lite_Computer is

 component Computer_System is
        port (
            arduino_gpio_export        : inout std_logic_vector(15 downto 0) := (others => 'X'); -- export
            arduino_reset_n_export     : out   std_logic;                                        -- export
            expansion_jp1_export       : inout std_logic_vector(31 downto 0) := (others => 'X'); -- export
				hex3_hex0_export           : out   std_logic_vector(31 downto 0);                     -- export
				hex5_hex4_export           : out   std_logic_vector(15 downto 0);                     -- export
            leds_export                : out   std_logic_vector(9 downto 0);                     -- export
            pushbuttons_export         : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- export
            sdram_addr                 : out   std_logic_vector(12 downto 0);                    -- addr
            sdram_ba                   : out   std_logic_vector(1 downto 0);                     -- ba
            sdram_cas_n                : out   std_logic;                                        -- cas_n
            sdram_cke                  : out   std_logic;                                        -- cke
            sdram_cs_n                 : out   std_logic;                                        -- cs_n
            sdram_dq                   : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
            sdram_dqm                  : out   std_logic_vector(1 downto 0);                     -- dqm
            sdram_ras_n                : out   std_logic;                                        -- ras_n
            sdram_we_n                 : out   std_logic;                                        -- we_n
            sdram_clk_clk              : out   std_logic;                                        -- clk
				servo1_export              : out   std_logic_vector(7 downto 0);                     -- export
            servo2_export              : out   std_logic_vector(7 downto 0);                     -- export
            slider_switches_export     : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- export
            system_pll_ref_clk_clk     : in    std_logic                     := 'X';             -- clk
            system_pll_ref_reset_reset : in    std_logic                     := 'X';             -- reset
            video_lt24_controller_0_external_interface_lcd_on  : out   std_logic;                                        -- lcd_on
            video_lt24_controller_0_external_interface_reset_n : out   std_logic;                                        -- reset_n
            video_lt24_controller_0_external_interface_csx     : out   std_logic;                                        -- csx
            video_lt24_controller_0_external_interface_data    : out   std_logic_vector(15 downto 0);                    -- data
            video_lt24_controller_0_external_interface_rdx     : out   std_logic;                                        -- rdx
            video_lt24_controller_0_external_interface_wrx     : out   std_logic;                                        -- wrx
            video_lt24_controller_0_external_interface_dcx     : out   std_logic;                                        -- dcx
            video_pll_0_ref_clk_clk                            : in    std_logic                     := 'X';             -- clk
            video_pll_0_ref_reset_reset                        : in    std_logic                     := 'X';              -- reset
            lt24_touch_adc_busy                                : in    std_logic                     := 'X';             -- adc_busy
            lt24_touch_adc_cs                                  : out   std_logic;                                        -- adc_cs
            lt24_touch_adc_dclk                                : out   std_logic;                                        -- adc_dclk
            lt24_touch_adc_din                                 : out   std_logic;                                        -- adc_din
            lt24_touch_adc_dout                                : in    std_logic                     := 'X';             -- adc_dout
            lt24_touch_adc_penirq_n                            : in    std_logic                     := 'X';             -- adc_penirq_n
            lt24_touch_clk50mhz                                : in    std_logic                     := 'X';              -- clk50mhz
				accel_i2c_sda_in                                   : in    std_logic                     := 'X';             -- sda_in
            accel_i2c_scl_in                                   : in    std_logic                     := 'X';             -- scl_in
            accel_i2c_sda_oe                                   : out   std_logic;                                        -- sda_oe
            accel_i2c_scl_oe                                   : out   std_logic                                         -- scl_oe
        );
    end component Computer_System;
	 
	 component seg7 is
	 port(

			instructuion: in std_logic_vector(31 downto 0);
			hexOut: out std_logic_vector(31 downto 0)

	 );
	 end component seg7;
	 
	 component seg7_16bit is
	 port(

			instructuion: in std_logic_vector(15 downto 0);
			hexOut: out std_logic_vector(15 downto 0)

	 );
	 end component seg7_16bit;
	 
	 component servo1 is
	 port(
			data 	  : in std_logic_vector(7 downto 0);
			clk 	  : in std_logic;
			servoOut : out std_logic);
	 end component servo1;
	 
	 component servo2 is
	 port(
			data 	  : in std_logic_vector(7 downto 0);
			clk 	  : in std_logic;
			servoOut : out std_logic);
	 end component servo2;

	 signal hex3_hex0 : std_logic_vector(31 downto 0); 
	 signal hex5_hex4 : std_logic_vector(15 downto 0);
	 
	 signal servo1EXP : std_logic_vector(7 downto 0);
	 signal servo2EXP : std_logic_vector(7 downto 0);
	 
	 signal servo1Driver : std_logic;
	 signal servo2Driver : std_logic;
	 
	 signal dqm : std_logic_vector(1 downto 0);
	 signal jp1 : std_logic_vector(31 downto 0);
	 
	 signal LT24data: std_logic_vector(15 downto 0);
	 
	 signal ADC_BUSY, ADC_CS_N, ADC_DCLK, ADC_DIN, ADC_DOUT, ADC_PENIRO_n: std_logic;
	 
	 signal SCL_IN, SDA_IN, SCL_OE, SDA_OE: std_logic;


begin 

	
	DRAM_UDQM <= dqm(1);
	DRAM_LDQM <= dqm(0);
	

	u0 : component Computer_System
        port map (
				system_pll_ref_clk_clk     => CLOCK_50,     --   system_pll_ref_clk.clk
            system_pll_ref_reset_reset => '0',  -- system_pll_ref_reset.reset
    
				arduino_gpio_export(15 downto 11)        => ARDUINO_IO(15 downto 11),        --         arduino_gpio.export
				arduino_gpio_export(10 downto 9)        => open,        --         arduino_gpio.export
				arduino_gpio_export(8 downto 2)        => ARDUINO_IO(8 downto 2),        --         arduino_gpio.export
				arduino_gpio_export(1 downto 0)        => open,
            arduino_reset_n_export     => ARDUINO_RESET_N,     --      arduino_reset_n.export

				slider_switches_export     => SW,     --      slider_switches.export

				pushbuttons_export         => not KEY,         --          pushbuttons.export

				
            expansion_jp1_export       => jp1,       --        expansion_jp1.export


		      hex3_hex0_export           => hex3_hex0,            --            hex3_hex0.export
				hex5_hex4_export           => hex5_hex4,           --            hex5_hex4.export
 
				leds_export                => LEDR,                --                 leds.export


				sdram_addr                 => DRAM_ADDR,                 --                sdram.addr
            sdram_ba                   => DRAM_BA,                   --                     .ba
            sdram_cas_n                => DRAM_CAS_N,                --                     .cas_n
            sdram_cke                  => DRAM_CKE,                  --                     .cke
            sdram_cs_n                 => DRAM_CS_N,                 --                     .cs_n
            sdram_dq                   => DRAM_DQ,                   --                     .dq
            sdram_dqm                  => dqm,                  --                     .dqm
            sdram_ras_n                => DRAM_RAS_N,                --                     .ras_n
            sdram_we_n                 => DRAM_WE_N,                 --                     .we_n
            sdram_clk_clk              => DRAM_CLK,              --          sdram_clk.clk
				
				servo1_export              => servo1EXP,           --            servo1.export
            servo2_export              => servo2EXP,           --            servo2.export
            video_lt24_controller_0_external_interface_lcd_on  => GPIO(35),  -- video_lt24_controller_0_external_interface.lcd_on
            video_lt24_controller_0_external_interface_reset_n => GPIO(33), --                                           .reset_n
            video_lt24_controller_0_external_interface_csx     => GPIO(25),     --                                           .csx
            video_lt24_controller_0_external_interface_data    => LT24data,    --                                           .data
            video_lt24_controller_0_external_interface_rdx     => GPIO(10),     --                                           .rdx
            video_lt24_controller_0_external_interface_wrx     => GPIO(11),     --                                           .wrx
            video_lt24_controller_0_external_interface_dcx     => GPIO(12),     --                                           .dcx
            video_pll_0_ref_clk_clk                            => CLOCK_50,                            --                        video_pll_0_ref_clk.clk
            video_pll_0_ref_reset_reset                        => '0',                         --                      video_pll_0_ref_reset.reset
				lt24_touch_adc_busy                                => ADC_BUSY,                                --                                 lt24_touch.adc_busy
            lt24_touch_adc_cs                                  => ADC_CS_N,                                  --                                           .adc_cs
            lt24_touch_adc_dclk                                => ADC_DCLK,                                --                                           .adc_dclk
            lt24_touch_adc_din                                 => ADC_DIN,                                 --                                           .adc_din
            lt24_touch_adc_dout                                => ADC_DOUT,                                --                                           .adc_dout
            lt24_touch_adc_penirq_n                            => ADC_PENIRO_n,                            --                                           .adc_penirq_n
            lt24_touch_clk50mhz                                => CLOCK_50,                                --                                           .clk50mhz
				accel_i2c_sda_in                                   => SDA_IN,                                   --                                  accel_i2c.sda_in
            accel_i2c_scl_in                                   => SCL_IN,                                   --                                           .scl_in
            accel_i2c_sda_oe                                   => SDA_OE,                                   --                                           .sda_oe
            accel_i2c_scl_oe                                   => SCL_OE                                    --                                           .scl_oe
                        
        );
		  
	--DB0
	GPIO(8) <= LT24data(0);
	--DB1
	GPIO(7) <= LT24data(1);
	--DB2
	GPIO(6) <= LT24data(2);
	--DB3
	GPIO(5) <= LT24data(3);
	--DB15-DB4
	GPIO(24 downto 13) <= LT24data(15 downto 4);
	--ADC_DCLK
	GPIO(4) <= ADC_DCLK;
	--ADC_DIN
	GPIO(3) <= ADC_DIN;
	--ADC_BUSY
	ADC_BUSY <= GPIO(2);
	--ADC_DOUT
	ADC_DOUT <= GPIO(1);
	--ADC_PENIRO_n
	ADC_PENIRO_n <= GPIO(0);
	--ADC_CS_n
	GPIO(34) <= ADC_CS_N;
	--UNUSED

	
	HEXOUT3_0 : seg7 port map(

			instructuion => hex3_hex0,
			hexOut => HEX0_3

	 );
	 
	 HEXOUT5_4 : seg7_16bit port map(

			instructuion => hex5_hex4,
			hexOut => HEX4_5

	 );
	 
	 SERVO1CONTROL : servo1 port map(
			data => servo1EXP,
			clk => CLOCK_50,
			servoOut => servo1Driver
	 );
			
	 SERVO2CONTROL : servo2 port map(
			data => servo2EXP,
			clk => CLOCK_50,
			servoOut => servo2Driver
	 );
	 
	HEX0 <= not HEX0_3(7 downto 0);
	HEX1 <= not HEX0_3(15 downto 8);
	HEX2 <= not HEX0_3(23 downto 16);
	HEX3 <= not HEX0_3(31 downto 24);
	HEX4 <= not HEX4_5(7 downto 0);
	HEX5 <= not HEX4_5(15 downto 8);				
	
	ARDUINO_IO(9) <= servo1Driver;
	ARDUINO_IO(10) <= servo2Driver;
	
	SCL_IN <= G_SENSOR_SCLK;
	G_SENSOR_SCLK <= '0' when SCL_OE = '1' else 'Z';
	
	SDA_IN <= G_SENSOR_SDI;
	G_SENSOR_SDI <= '0' when SDA_OE = '1' else 'Z';
	
	G_SENSOR_SDO <= '0';
	G_SENSOR_CS_N <= '1';
	
	ARDUINO_IO(0) <= G_SENSOR_SDI;
	ARDUINO_IO(1) <= G_SENSOR_SCLK;
	
end architecture STRUCTURAL;