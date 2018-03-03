-- Original Authors : Simon Doherty, Eric Lunty, Kyle Brooks, Peter Roland
-- Also combined that with the code from http://www.lancasterhunt.co.uk/direct-digital-synthesis-dds-for-idiots-like-me/
-- Additional Authors : Randi Derbyshire, Adam Narten, Oliver Rarog, Celeste Chiasson

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.math_real.all;
use ieee.VITAL_Primitives.all;
use IEEE.STD_LOGIC_SIGNED.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;
entity Synthesizer is 

	port(
	clk 			: in std_logic:= '0'; 
	reset 		: in std_logic:= '0'; 
	write		: in std_logic:= '0'; 
	read		: in std_logic:= '0'; 
	--ad_converter : in std_logic;

	-- frequnecy input
	phase_reg1 : in std_logic_vector(31 downto 0) := (others => '0'); 

	-- Sine waveform from laser
	data_out1 : out std_logic_vector(31 downto 0)
	);

end Synthesizer;



architecture full_dds of Synthesizer is

component sin_lut is 

	port (
	clk : in std_logic;
	en		: in std_logic;

	-- take in the values from the phase accumulator.
	-- All of the address inputs.
	address_reg1 : in std_logic_vector(11 downto 0); 

	-- All of the sine outputs.
	sin_out1  : out std_logic_vector(31 downto 0)
	);

end component sin_lut;

signal phase_acc1 : std_logic_vector(31 downto 0);

signal lut_data1 : std_logic_vector(31 downto 0);

signal lut_data_reg1 : std_logic_vector(31 downto 0);

begin

dds : process(clk, reset, write)

begin

	if (reset = '1') then
		phase_acc1 <= x"00000000"; -- reset accumulator.

	elsif (rising_edge(clk)) then 
		if (write = '1') then
			--at every falling edge, we are adding/changing the phase to the accumulator.
			phase_acc1 <= unsigned(phase_acc1) + unsigned(phase_reg1);
		end if;
	end if;

end process dds;

---------------------------------------------------------------------
-- use top 12-bits of phase accumulator to address the SIN LUT --
---------------------------------------------------------------------

lut_data1 <= phase_acc1(31 downto 0);


----------------------------------------------------------------------
-- SIN LUT is 4096 by 12-bit ROM                                    --
-- 12-bit output allows sin amplitudes between 2047 and -2047       --
-- (-2048 not used to keep the output signal perfectly symmetrical) --
-- Phase resolution is 2Pi/4096 = 0.088 degrees                     --
----------------------------------------------------------------------

lut: component sin_lut  port map (
		clk       => clk,
		en        => write,
	 
    	address_reg1      => lut_data1(11 downto 0),
	
		sin_out1 	=> data_out1

  );


---------------------------------
-- Hide the latency of the LUT --
---------------------------------

delay_regs: process(clk, write)
begin
  if (rising_edge(clk)) then
		if (write = '1') then
			lut_data_reg1 <= lut_data1;
		end if;
	end if;
end process delay_regs;


end full_dds;
