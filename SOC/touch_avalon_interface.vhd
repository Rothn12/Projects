library ieee;
use ieee.std_logic_1164.all;

entity TestTouch is
port(
		--Avalon Interface
		clk, reset_n: in std_logic;
		irq: out std_logic;
		read, write: in std_logic;
		address: in std_logic_vector(0 downto 0);
		byteenable_n: in std_logic_vector(3 downto 0); -- not needed
		writedata : in std_logic_vector(31 downto 0);
		readdata : out std_logic_vector(31 downto 0);
		
		--External Signals
		clk50MHz: in std_logic;
		adc_dout: in std_logic;
		adc_penirq_n: in std_logic;
		adc_busy: in std_logic;
		adc_din: out std_logic;
		adc_dclk: out std_logic;
		adc_cs: out std_logic);
end TestTouch;

architecture struct of TestTouch is
	 
	component adc_spi_controller port(
			iCLK, iRST_n, iADC_DOUT, iADC_PENIRQ_n, iADC_BUSY: in std_logic;
			oADC_DIN, oADC_DCLK, oADC_CS, oTOUCH_IRQ, oNEW_COORD: out std_logic;
			oX_COORD, oY_COORD: out std_logic_vector(11 downto 0));
	end component adc_spi_controller;
	
	signal sigEN, sigNC, sigIF, sigIE: std_logic;
	signal xCoord, yCoord: std_logic_vector(11 downto 0);
	
	signal to_iCLK: std_logic;
	
begin

	to_iCLK <= (clk50MHz and sigEN);

	u0: component adc_spi_controller port map(
						iCLK => to_iCLK,  --Making our own enable logic
						iRST_n => reset_n,
						iADC_DOUT => adc_dout,
						iADC_PENIRQ_n => adc_penirq_n,
						iADC_BUSY => adc_busy,
						oADC_DIN => adc_din,
						oADC_DCLK => adc_dclk,
						oADC_CS => adc_cs,
						oToUCH_IRQ => sigIF,
						oNEW_COORD => sigNC,
						oX_COORD => xCoord,
						oY_COORD => yCoord);
						
	irq <= sigIF and sigIE;
	
	
	--Avalon Stuff
	process(clk, reset_n)
	begin 
	
		if(reset_n = '0') then 
			sigEN <= '0';
			sigIE <= '0';
			
		elsif rising_edge(clk) then
			if (write = '1') then
				--Writing Enable and interrupt enable
				if(address(0) = '0') then
					sigEN <= writedata(0);
					sigIE <= writedata(2);
				end if;
			
			end if;
			
		end if;
	
	end process;
	
	readdata <= X"0000000" & sigIF & sigIE & sigNC & sigEN when (read = '1' and address(0) = '0') else 
					X"0" & yCoord & X"0" & xCoord when (read = '1' and address(0) = '1') else 
					x"00000000";
						
end architecture struct;