-- Original Authors : Simon Doherty, Eric Lunty, Kyle Brooks, Peter Roland
-- Also combined that with the code from http://www.lancasterhunt.co.uk/direct-digital-synthesis-dds-for-idiots-like-me/
-- Additional Authors : Randi Derbyshire, Adam Narten, Oliver Rarog, Celeste Chiasson

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.math_real.all;

entity synthesizer is 

	port(
	clk : in std_logic;
	reset : in std_logic;
	ad_converter : in std_logic;

	
	phase_reg1 : in std_logic_vector(31 downto 0);
	phase_reg2 : in std_logic_vector(31 downto 0);
	phase_reg3 : in std_logic_vector(31 downto 0);
	phase_reg4 : in std_logic_vector(31 downto 0);
	phase_reg5 : in std_logic_vector(31 downto 0);
	phase_reg6 : in std_logic_vector(31 downto 0);
	phase_reg7 : in std_logic_vector(31 downto 0);
	phase_reg8 : in std_logic_vector(31 downto 0);

	-- 8 waveforms for 8 lasers
	data_out1 : out std_logic_vector(11 downto 0);
	data_out2 : out std_logic_vector(11 downto 0);
	data_out3 : out std_logic_vector(11 downto 0);
	data_out4 : out std_logic_vector(11 downto 0);
	data_out5 : out std_logic_vector(11 downto 0);
	data_out6 : out std_logic_vector(11 downto 0);
	data_out7 : out std_logic_vector(11 downto 0);
	data_out8 : out std_logic_vector(11 downto 0); 
	);

end entitiy synthesizer;


architecture full_dds of synthesizer is

component sine_lut is 

	port (
	clk : in std_logic;
	reset : in std_logic;

	-- take in the values from the phase accumulator.
	-- All of the address inputs.
	address_reg1 : in std-logic_vector(11 downto 0); 
	address_reg2 : in std-logic_vector(11 downto 0);
	address_reg3 : in std-logic_vector(11 downto 0);
	address_reg4 : in std-logic_vector(11 downto 0);
	address_reg5 : in std-logic_vector(11 downto 0);
	address_reg6 : in std-logic_vector(11 downto 0);
	address_reg7 : in std-logic_vector(11 downto 0);
	address_reg8 : in std-logic_vector(11 downto 0);

	-- All of the sine outputs.
	data_out1 : out std_logic_vector(11 downto 0);
	data_out2 : out std_logic_vector(11 downto 0);
	data_out3 : out std_logic_vector(11 downto 0);
	data_out4 : out std_logic_vector(11 downto 0);
	data_out5 : out std_logic_vector(11 downto 0);
	data_out6 : out std_logic_vector(11 downto 0);
	data_out7 : out std_logic_vector(11 downto 0);
	data_out8 : out std_logic_vector(11 downto 0);
	)

end component sine_lut;

signal phase_acc1 : std_logic_vector(31 downto 0);
signal phase_acc2 : std_logic_vector(31 downto 0);
signal phase_acc3 : std_logic_vector(31 downto 0);
signal phase_acc4 : std_logic_vector(31 downto 0);
signal phase_acc5 : std_logic_vector(31 downto 0);
signal phase_acc6 : std_logic_vector(31 downto 0);
signal phase_acc7 : std_logic_vector(31 downto 0);
signal phase_acc8 : std_logic_vector(31 downto 0);

--signal freq_step1 : std_logic_vector(31 downto 0);
--signal freq_step2 : std_logic_vector(31 downto 0);
--signal freq_step3 : std_logic_vector(31 downto 0);
--signal freq_step4 : std_logic_vector(31 downto 0);
--signal freq_step5 : std_logic_vector(31 downto 0);
--signal freq_step6 : std_logic_vector(31 downto 0);
--signal freq_step7 : std_logic_vector(31 downto 0);
--signal freq_step8 : std_logic_vector(31 downto 0);

signal lut_data1 : std_logic_vector(11 downto 0);
signal lut_data2 : std_logic_vector(11 downto 0);
signal lut_data3 : std_logic_vector(11 downto 0);
signal lut_data4 : std_logic_vector(11 downto 0);
signal lut_data5 : std_logic_vector(11 downto 0);
signal lut_data6 : std_logic_vector(11 downto 0);
signal lut_data7 : std_logic_vector(11 downto 0);
signal lut_data8 : std_logic_vector(11 downto 0);

signal lut_data_reg1 : std_logic_vector(11 downto 0);
signal lut_data_reg2 : std_logic_vector(11 downto 0);
signal lut_data_reg3 : std_logic_vector(11 downto 0);
signal lut_data_reg4 : std_logic_vector(11 downto 0);
signal lut_data_reg5 : std_logic_vector(11 downto 0);
signal lut_data_reg6 : std_logic_vector(11 downto 0);
signal lut_data_reg7 : std_logic_vector(11 downto 0);
signal lut_data_reg8 : std_logic_vector(11 downto 0);



begin

dds : process(clk, reset)

begin

	if (reset = '0') then
		phase_acc1 <= x"00000000" -- reset accumulator.
		phase_acc2 <= x"00000000" -- reset accumulator.
		phase_acc3 <= x"00000000" -- reset accumulator.
		phase_acc4 <= x"00000000" -- reset accumulator.
		phase_acc5 <= x"00000000" -- reset accumulator.
		phase_acc6 <= x"00000000" -- reset accumulator.
		phase_acc7 <= x"00000000" -- reset accumulator.
		phase_acc8 <= x"00000000" -- reset accumulator.

	else if (rising_edge(clk)) then 
		-- at every falling edge, we are adding/changing the phase to the accumulator.
		phase_acc1 <= unsigned(phase_acc1) + unsigned(phase_reg1);
		phase_acc2 <= unsigned(phase_acc2) + unsigned(phase_reg2);
		phase_acc3 <= unsigned(phase_acc3) + unsigned(phase_reg3);
		phase_acc4 <= unsigned(phase_acc4) + unsigned(phase_reg4);
		phase_acc5 <= unsigned(phase_acc5) + unsigned(phase_reg5);
		phase_acc6 <= unsigned(phase_acc6) + unsigned(phase_reg6);
		phase_acc7 <= unsigned(phase_acc7) + unsigned(phase_reg7);
		phase_acc8 <= unsigned(phase_acc8) + unsigned(phase_reg8);
--	else 
--		lut_data1;
--		lut_data2;
--		lut_data3;
--		lut_data4;
--		lut_data5;
--		lut_data6;
--		lut_data7;
--		lut_data8;
	end if;

end process dds;

---------------------------------------------------------------------
-- use top 12-bits of phase accumulator to address the SIN LUT --
---------------------------------------------------------------------

lut_data1 <= phase_acc1(31 downto 20);
lut_data2 <= phase_acc2(31 downto 20);
lut_data3 <= phase_acc3(31 downto 20);
lut_data4 <= phase_acc4(31 downto 20);
lut_data5 <= phase_acc5(31 downto 20);
lut_data6 <= phase_acc6(31 downto 20);
lut_data7 <= phase_acc5(31 downto 20);
lut_data8 <= phase_acc6(31 downto 20);

--if (ad_converter = '1')
--	data_out1 <= phase_acc1 (31 downto 20);
--	data_out2 <= phase_acc2 (31 downto 20);
--	data_out3 <= phase_acc3 (31 downto 20);
--	data_out4 <= phase_acc4 (31 downto 20);
--	data_out5 <= phase_acc5 (31 downto 20);
--	data_out6 <= phase_acc6 (31 downto 20);
--	data_out7 <= phase_acc7 (31 downto 20);
--	data_out8 <= phase_acc8 (31 downto 20);
--
--else 
--	lut_data1;
--	lut_data2;
--	lut_data3;
--	lut_data4;
--	lut_data5;
--	lut_data6;
--	lut_data7;
--	lut_data8;
--
--end if;

----------------------------------------------------------------------
-- SIN LUT is 4096 by 12-bit ROM                                    --
-- 12-bit output allows sin amplitudes between 2047 and -2047       --
-- (-2048 not used to keep the output signal perfectly symmetrical) --
-- Phase resolution is 2Pi/4096 = 0.088 degrees                     --
----------------------------------------------------------------------

lut: sin_lut

  port map
  (
    	clk       => clk,
    	--en        => en,
	 
    	address_reg1      => lut_data1,
	address_reg2      => lut_data2,
	address_reg3      => lut_data3,
	address_reg4      => lut_data4,
	address_reg5      => lut_data5,
	address_reg6      => lut_data6,
	address_reg7      => lut_data7,
	address_reg8      => lut_data8,
	 
	data_out1   => sin_out1,
	data_out2   => sin_out2,
	data_out3   => sin_out3,
	data_out4   => sin_out4,
	data_out5   => sin_out5,
	data_out6   => sin_out6,
	data_out7   => sin_out7,
	data_out8   => sin_out8
  );


---------------------------------
-- Hide the latency of the LUT --
---------------------------------

delay_regs: process(clk)
begin
  if (rising_edge(clk)) then
      	lut_data_reg1 <= lut_addr1;
	lut_data_reg2 <= lut_addr2;
	lut_data_reg3 <= lut_addr3;
	lut_data_reg4 <= lut_addr4;
	lut_data_reg5 <= lut_addr5;
	lut_data_reg6 <= lut_addr6;
	lut_data_reg7 <= lut_addr7;
	lut_data_reg8 <= lut_addr8;
  end if;
end process delay_regs;


end architecture full_dds;
