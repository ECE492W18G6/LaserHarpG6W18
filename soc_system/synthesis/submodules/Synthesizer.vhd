--------------------------------------------------------------------------------------------------------------------------
-- Original Authors : Simon Doherty, Eric Lunty, Kyle Brooks, Peter Roland						--
-- Date created: N/A 													--
-- Date edited: February 5, 2018											--
-- Also combined that with the code from http://www.lancasterhunt.co.uk/direct-digital-synthesis-dds-for-idiots-like-me/--
-- Additional Authors : Randi Derbyshire, Adam Narten, Oliver Rarog, Celeste Chiasson					--
--															--
-- This program takes a frequency and steps it through a phase accumulator. The phase accumulator sums the current 	--
-- phase with the clock. This will step through the sine lookup table and create the respective sine wave for that	--
-- original frequency called.												--
--															--
--------------------------------------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
USE ieee.std_logic_arith.all;

entity Synthesizer is 

	port(
	-- system signals
	clk 			: in std_logic:= '0'; 
	reset 		: in std_logic:= '0'; 
	write		: in std_logic:= '0'; 
	read		: in std_logic:= '0'; 
	
	-- frequnecy input
	phase_reg : in std_logic_vector(31 downto 0); 
	-- Sine waveform from laser
	data_out : out std_logic_vector(31 downto 0)
	);
	
end Synthesizer;

architecture full_dds of Synthesizer is

component PianoSin_lut is 

	port (
	clk : in std_logic;
	en		: in std_logic;

	-- take in the values from the phase accumulator.
	address_reg : in std_logic_vector(11 downto 0); 
	sin_out  : out std_logic_vector(31 downto 0)
	);

end component PianoSin_lut;

component ClarinetSin_lut is 

	port (
	clk : in std_logic;
	en		: in std_logic;

	-- take in the values from the phase accumulator.
	address_reg : in std_logic_vector(11 downto 0); 
	sin_out  : out std_logic_vector(31 downto 0)
	);

end component ClarinetSin_lut;

component ViolinSin_lut is 

	port (
	clk : in std_logic;
	en		: in std_logic;

	-- take in the values from the phase accumulator.
	address_reg : in std_logic_vector(11 downto 0); 
	sin_out  : out std_logic_vector(31 downto 0)
	);

end component ViolinSin_lut;

component HarpSin_lut is 

	port (
	clk : in std_logic;
	en		: in std_logic;

	-- take in the values from the phase accumulator.
	address_reg : in std_logic_vector(11 downto 0); 
	sin_out  : out std_logic_vector(31 downto 0)
	);

end component HarpSin_lut;

component Mux8X1 is
	generic (N : Integer := 32);
	port (
		clk 			: in std_logic:= '0'; 
		sel			:	in std_logic_vector(2 downto 0);
		data_in0		: 	in std_logic_vector(31 downto 0); 
		data_in1		: 	in std_logic_vector(31 downto 0); 
		data_in2		: 	in std_logic_vector(31 downto 0); 
		data_in3		: 	in std_logic_vector(31 downto 0); 
		data_in4		: 	in std_logic_vector(31 downto 0); 
		data_in5		: 	in std_logic_vector(31 downto 0); 
		data_in6		: 	in std_logic_vector(31 downto 0); 
		data_in7		: 	in std_logic_vector(31 downto 0); 
		data_out		:	out std_logic_vector(31 downto 0)
	);
end component Mux8X1;

component Mux4X1 is
	generic (N : Integer := 32);
	port (
		clk 			: in std_logic:= '0'; 
		sel			:	in std_logic_vector(1 downto 0);
		data_in0		: 	in std_logic_vector(31 downto 0); 
		data_in1		: 	in std_logic_vector(31 downto 0); 
		data_in2		: 	in std_logic_vector(31 downto 0); 
		data_in3		: 	in std_logic_vector(31 downto 0); 
		data_out		:	out std_logic_vector(31 downto 0)
	);
end component Mux4X1;

signal phase1_acc : std_logic_vector(31 downto 0);
signal phase2_acc : std_logic_vector(31 downto 0);
signal phase3_acc : std_logic_vector(31 downto 0);
signal phase4_acc : std_logic_vector(31 downto 0);
signal phase5_acc : std_logic_vector(31 downto 0);
signal phase6_acc : std_logic_vector(31 downto 0);
signal phase7_acc : std_logic_vector(31 downto 0);
signal phase8_acc : std_logic_vector(31 downto 0);

signal indexOut	: std_logic_vector(31 downto 0);
signal lut_data : std_logic_vector(31 downto 0);
signal lut_data_reg : std_logic_vector(31 downto 0);

signal instrumentSel	: std_logic_vector(1 downto 0);
signal diodeSel		: std_logic_vector(2 downto 0);

signal Harplut_data		: std_logic_vector(31 downto 0) := X"00000000";
signal Pianolut_data		: std_logic_vector(31 downto 0) := X"00000000";
signal Clarinetlut_data	: std_logic_vector(31 downto 0) := X"00000000";
signal Violinlut_data	: std_logic_vector(31 downto 0) := X"00000000";


begin

----------------------------------------------------------------------
-- SIN LUT is 4096 by 12-bit ROM                                    --
-- 12-bit output allows sin amplitudes between 2047 and -2047       --
-- (-2048 not used to keep the output signal perfectly symmetrical) --
-- Phase resolution is 2Pi/4096 = 0.088 degrees                     --
----------------------------------------------------------------------
Pianolut: component PianoSin_lut  port map (
		clk       => clk,
		en        => write,
    	address_reg      => indexOut(11 downto 0),
		sin_out 	=> Pianolut_data
 );
 
Clarinetlut: component ClarinetSin_lut  port map (
		clk       => clk,
		en        => write,
    	address_reg      => indexOut(11 downto 0),
		sin_out 	=> Clarinetlut_data
 );
 
Violinlut: component ViolinSin_lut  port map (
		clk       => clk,
		en        => write,
    	address_reg      => indexOut(11 downto 0),
		sin_out 	=> Violinlut_data
 );
 
Harplut: component HarpSin_lut  port map (
		clk       => clk,
		en        => write,
    	address_reg      => indexOut(11 downto 0),
		sin_out 	=> Harplut_data
 );

 mux8: component Mux8X1 port map (
	clk		=> clk,
	sel		=> diodeSel,
	data_in0	=> phase1_acc,
	data_in1	=> phase2_acc,
	data_in2	=> phase3_acc,
	data_in3	=> phase4_acc,
	data_in4	=> phase5_acc,
	data_in5	=> phase6_acc,
	data_in6	=> phase7_acc,
	data_in7	=> phase8_acc,
	data_out	=> indexOut
);
 
mux4: component Mux4X1 port map (
	clk		=> clk,
	sel		=> instrumentSel,
	data_in0	=> Harplut_data,
	data_in1	=> Pianolut_data,
	data_in2	=> Clarinetlut_data,
	data_in3	=> Violinlut_data,
	data_out	=> data_out
);



counterControl : process(clk, write, phase_reg)
begin
	if (rising_edge(clk)) then
		if(write = '1') then
			diodeSel <= phase_reg(16 downto 14);
			instrumentSel <= phase_reg(13 downto 12);
			
			case diodeSel is
				-- the first 8 cases are when the reset is not enabled
				-- therefore, we increment the counter, unless its at the
				-- end in which case we stay at the end of the LUT
				when "000" => 
						phase1_acc <= unsigned(phase1_acc) + unsigned(phase_reg(11 downto 0));
				when "001" => 
						phase2_acc <= unsigned(phase2_acc) + unsigned(phase_reg(11 downto 0));
				when "010" => 
						phase3_acc <= unsigned(phase3_acc) + unsigned(phase_reg(11 downto 0));
				when "011" =>
						phase4_acc <= unsigned(phase4_acc) + unsigned(phase_reg(11 downto 0));
				when "100" => 
						phase5_acc <= unsigned(phase5_acc) + unsigned(phase_reg(11 downto 0));
				when "101" => 
						phase6_acc <= unsigned(phase6_acc) + unsigned(phase_reg(11 downto 0));
				when "110" => 
						phase7_acc <= unsigned(phase7_acc) + unsigned(phase_reg(11 downto 0));
				when "111" => 
						phase8_acc <= unsigned(phase8_acc) + unsigned(phase_reg(11 downto 0));
 			end case;
		end if;
	end if;
end process counterControl;

lut_data <= indexOut;

---------------------------------
-- Hide the latency of the LUT --
---------------------------------
delay_regs: process(clk, write)
begin
  if (rising_edge(clk)) then
		if (write = '1') then
			lut_data_reg <= lut_data;
		end if;
	end if;
end process delay_regs;

end full_dds;