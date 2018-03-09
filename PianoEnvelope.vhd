LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.math_real.all;
use ieee.VITAL_Primitives.all;
use IEEE.STD_LOGIC_SIGNED.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity PianoEnvelope is 

	port(
	-- system signals
	clk 			: in std_logic:= '0'; 
	reset 		: in std_logic:= '0'; 
	read			: in std_logic:= '0'; 
	write			: in std_logic:= '0';
	en				: in std_logic_vector(31 downto 0);
	data_out 	: out std_logic_vector(31 downto 0)
	);
	
end PianoEnvelope;

architecture rtl of PianoEnvelope is

component PianoEnvelope_lut is 
	port (
	clk : in std_logic;
	en		: in std_logic;
	reset 		: in std_logic;
	index		: in std_logic_vector(11 downto 0);
	data_out  : out std_logic_vector(31 downto 0)
	);

end component PianoEnvelope_lut;

signal counter : std_logic_vector(11 downto 0);

begin

lut: component PianoEnvelope_lut  port map (
		clk      	=> clk,
		en       	=> read,
		reset 		=> reset,
		index			=> counter,
		data_out 	=> data_out
);

enableLUT : process(clk, reset, read)

begin

	if (reset = '1') then
		counter <= x"000"; -- reset accumulator.

	elsif (rising_edge(clk)) then
		if (write = '1') then
			counter <= counter + 1;
		end if;
	end if;

end process enableLUT;
 
end rtl;
