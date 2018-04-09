--------------------------------------------------------------------------------------------------------------------------------
-- Original Authors : Oliver Rarog					                                                                          --
-- Date created: March 11, 2018 													                                          --
-- Date edited: March 13, 2018											                                                      --
-- Additional Authors : Celeste Chiasson					                                                                  --
--															                                                                  --
-- This component is a controller for a sound envelope lookup tables. It can keep track of the envelope of up to 8            --
-- inputs. For the use of the laser harp, this means that it can keep track of where each of the 8 diodes is in their         --
-- envelope. In order to control the envelope controller, refer to the register map below.                                    --
--                                                                                                                            --
-- -------------------------------------------------------------------------------------------------------------------------- --
-- | Bits   |                                              Results of the options                                           | --
-- -------------------------------------------------------------------------------------------------------------------------- --
-- | 0 - 2  | The number of the diode you want to get the envelope value for. i.e: 000 => diode 0, 010 => diode 2 etc.      | --					
-- |   3    | If this is '1', then the currently selected diode will reset its position in the envelope LUT to 0            | --
-- | 4 - 5  | Selects which instruments LUT you want to step through, 00 => Harp, 01 => Piano, 10 => Clarinet, 11 => harpsichord | -- 
--  ------------------------------------------------------------------------------------------------------------------------- --
-- This component works by keeping a counter signal for each diode, when the user writes their options, the counters are      --
-- muxed together with bits 0 - 2, to select which counter should go through to the LUT. The counter is used as an index      --
-- for its position in the envelope LUT. The output of the LUT is then connected to the data_out signal so that the envelope  --
-- value can be read. Each diode can be tracked individually and when the end of the LUT is reached, the output is 0 until    --
-- that diode is reset.                                                                                                       --
--------------------------------------------------------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity EnvelopeController is 
	port(
	-- system signals
	clk 			: in std_logic:= '0'; 
	reset 		: in std_logic:= '0'; 
	read			: in std_logic:= '0'; 
	write			: in std_logic:= '0';
	data_in		: in std_logic_vector(31 downto 0);
	data_out	 	: out std_logic_vector(31 downto 0)
	);
	
end EnvelopeController;

architecture rtl of EnvelopeController is

component HarpEnvelope_lut is 
	port (
	clk 			: in std_logic;
	en				: in std_logic;
	reset 		: in std_logic;
	index			: in std_logic_vector(11 downto 0);
	data_out  	: out std_logic_vector(31 downto 0)
	);

end component HarpEnvelope_lut;

component PianoEnvelope_lut is 
	port (
	clk 			: in std_logic;
	en				: in std_logic;
	reset 		: in std_logic;
	index			: in std_logic_vector(11 downto 0);
	data_out  	: out std_logic_vector(31 downto 0)
	);

end component PianoEnvelope_lut;

component ClarinetEnvelope_lut is 
	port (
	clk 			: in std_logic;
	en				: in std_logic;
	reset 		: in std_logic;
	index			: in std_logic_vector(11 downto 0);
	data_out  	: out std_logic_vector(31 downto 0)
	);

end component ClarinetEnvelope_lut;

component HarpsichordEnvelope_lut is 
	port (
	clk 			: in std_logic;
	en				: in std_logic;
	reset 		: in std_logic;
	index			: in std_logic_vector(11 downto 0);
	data_out  	: out std_logic_vector(31 downto 0)
	);

end component HarpsichordEnvelope_lut;

component Mux8X1 is
	generic (N : Integer := 12);
	port (
		clk 			: in std_logic:= '0'; 
		sel			:	in std_logic_vector(2 downto 0);
		data_in0		: 	in std_logic_vector(11 downto 0); 
		data_in1		: 	in std_logic_vector(11 downto 0); 
		data_in2		: 	in std_logic_vector(11 downto 0); 
		data_in3		: 	in std_logic_vector(11 downto 0); 
		data_in4		: 	in std_logic_vector(11 downto 0); 
		data_in5		: 	in std_logic_vector(11 downto 0); 
		data_in6		: 	in std_logic_vector(11 downto 0); 
		data_in7		: 	in std_logic_vector(11 downto 0); 
		data_out		:	out std_logic_vector(11 downto 0)
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

signal counterDiode1 	: std_logic_vector(11 downto 0) := X"000";
signal counterDiode2 	: std_logic_vector(11 downto 0) := X"000";
signal counterDiode3 	: std_logic_vector(11 downto 0) := X"000";
signal counterDiode4 	: std_logic_vector(11 downto 0) := X"000";
signal counterDiode5 	: std_logic_vector(11 downto 0) := X"000";
signal counterDiode6 	: std_logic_vector(11 downto 0) := X"000";
signal counterDiode7 	: std_logic_vector(11 downto 0) := X"000";
signal counterDiode8		: std_logic_vector(11 downto 0) := X"000";
signal counterOut			: std_logic_vector(11 downto 0) := X"000";

signal harpLUT_out		: std_logic_vector(31 downto 0) := X"00000000";
signal pianoLUT_out		: std_logic_vector(31 downto 0) := X"00000000";
signal clarinetLUT_out	: std_logic_vector(31 downto 0) := X"00000000";
signal harpsichordLUT_out		: std_logic_vector(31 downto 0) := X"00000000";

begin

HarpLUT: component HarpEnvelope_lut  port map (
		clk      	=> clk,
		en       	=> write,
		reset 		=> reset,
		index			=> counterOut,
		data_out 	=> harpLUT_out
);

PianoLUT: component PianoEnvelope_lut  port map (
		clk      	=> clk,
		en       	=> write,
		reset 		=> reset,
		index			=> counterOut,
		data_out 	=> pianoLUT_out
);

ClarinetLUT: component ClarinetEnvelope_lut  port map (
		clk      	=> clk,
		en       	=> write,
		reset 		=> reset,
		index			=> counterOut,
		data_out 	=> clarinetLUT_out
);

HarpsichordLUT: component HarpsichordEnvelope_lut  port map (
		clk      	=> clk,
		en       	=> write,
		reset 		=> reset,
		index			=> counterOut,
		data_out 	=> harpsichordLUT_out
);

mux8: component Mux8X1 port map (
	clk		=> clk,
	sel		=> data_in(2 downto 0),
	data_in0	=> counterDiode1,
	data_in1	=> counterDiode2,
	data_in2	=> counterDiode3,
	data_in3	=> counterDiode4,
	data_in4	=> counterDiode5,
	data_in5	=> counterDiode6,
	data_in6	=> counterDiode7,
	data_in7	=> counterDiode8,
	data_out	=> counterOut
);

mux4: component Mux4X1 port map (
	clk		=> clk,
	sel		=> data_in(5 downto 4),
	data_in0	=> harpLUT_out,
	data_in1	=> pianoLUT_out,
	data_in2	=> clarinetLUT_out,
	data_in3	=> harpsichordLUT_out,
	data_out	=> data_out
);


counterControl : process(clk, write, data_in)
begin
	if (rising_edge(clk)) then
		if(write = '1') then
			case data_in(3 downto 0) is
				-- the first 8 cases are when the reset is not enabled
				-- therefore, we increment the counter, unless its at the
				-- end in which case we stay at the end of the LUT
				when "0000" => 
					if(counterDiode1 = 4095) then
						counterDiode1 <= X"FFF";
					else
						counterDiode1 <= counterDiode1 + 1;
					end if;
				when "0001" => 
					if(counterDiode2 = 4095) then
						counterDiode2 <= X"FFF";
					else
						counterDiode2 <= counterDiode2 + 1;
					end if;
				when "0010" => 
					if(counterDiode3 = 4095) then
						counterDiode3 <= X"FFF";
					else
						counterDiode3 <= counterDiode3 + 1;
					end if;
				when "0011" =>
					if(counterDiode4 = 4095) then
						counterDiode4 <= X"FFF";
					else
						counterDiode4 <= counterDiode4 + 1;
					end if;
				when "0100" => 
					if(counterDiode5 = 4095) then
						counterDiode5 <= X"FFF";
					else
						counterDiode5 <= counterDiode5 + 1;
					end if;
				when "0101" => 
					if(counterDiode6 = 4095) then
						counterDiode6 <= X"FFF";
					else
						counterDiode6 <= counterDiode6 + 1;
					end if;
				when "0110" => 
					if(counterDiode7 = 4095) then
						counterDiode7 <= X"FFF";
					else
						counterDiode7 <= counterDiode7 + 1;
					end if;
				when "0111" => 
					if(counterDiode8 = 4095) then
						counterDiode8 <= X"FFF";
					else
						counterDiode8 <= counterDiode8 + 1;
					end if;
				-- These next 8 cases are when the reset is enabled
				-- therefore we reset the counter and flags for the diode
				when "1000" => counterDiode1 <= x"000";
				when "1001" => counterDiode2 <= x"000";
				when "1010" => counterDiode3 <= x"000";
				when "1011" => counterDiode4 <= x"000";
				when "1100" => counterDiode5 <= x"000";
				when "1101" => counterDiode6 <= x"000";
				when "1110" => counterDiode7 <= x"000";
				when "1111" => counterDiode8 <= x"000";
				when others => 
 			end case;
		end if;
	end if;
end process counterControl;


end rtl;
