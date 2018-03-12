LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.math_real.all;
use ieee.VITAL_Primitives.all;
use IEEE.STD_LOGIC_SIGNED.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity EnvelopeController is 

	port(
	-- system signals
	clk 			: in std_logic:= '0'; 
	reset 			: in std_logic:= '0'; 
	read			: in std_logic:= '0'; 
	write			: in std_logic:= '0';
	data_in			: in std_logic_vector(31 downto 0);
	data_out	 	: out std_logic_vector(31 downto 0)
	);
	
end EnvelopeController;

architecture rtl of EnvelopeController is

component PianoEnvelope_lut is 
	port (
	clk 			: in std_logic;
	en				: in std_logic;
	reset 		: in std_logic;
	index			: in std_logic_vector(11 downto 0);
	data_out  	: out std_logic_vector(31 downto 0)
	);

end component PianoEnvelope_lut;

component Mux8X1 is
	port (
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

signal counterDiode1 	: std_logic_vector(11 downto 0);
signal counterDiode2 	: std_logic_vector(11 downto 0);
signal counterDiode3 	: std_logic_vector(11 downto 0);
signal counterDiode4 	: std_logic_vector(11 downto 0);
signal counterDiode5 	: std_logic_vector(11 downto 0);
signal counterDiode6 	: std_logic_vector(11 downto 0);
signal counterDiode7 	: std_logic_vector(11 downto 0);
signal counterDiode8		: std_logic_vector(11 downto 0);
signal counterOut			: std_logic_vector(11 downto 0);

signal diode1End			: std_logic;
signal diode2End			: std_logic;
signal diode3End			: std_logic;
signal diode4End			: std_logic;
signal diode5End			: std_logic;
signal diode6End			: std_logic;
signal diode7End			: std_logic;
signal diode8End			: std_logic;

signal enableHarp			: std_logic;
signal enablePiano	 	: std_logic;
signal enableClarinet	: std_logic;
signal enableViolin		: std_logic;

begin

lut: component PianoEnvelope_lut  port map (
		clk      	=> clk,
		en       	=> enablePiano,
		reset 		=> reset,
		index			=> counterOut,
		data_out 	=> data_out
);

mux: component Mux8X1 port map (
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

enableInstrument : process(clk, write, data_in)
begin
	if(rising_edge(clk)) then
		case data_in(5 downto 4) is
			when "00" => 
				enableHarp 		<= '1';
				enablePiano 	<= '0';
				enableClarinet <= '0';
				enableViolin 	<= '0';
			when "01" => 
				enableHarp 		<= '0';
				enablePiano 	<= '1';
				enableClarinet <= '0';
				enableViolin 	<= '0';
			when "10" => 
				enableHarp 		<= '0';
				enablePiano 	<= '0';
				enableClarinet <= '1';
				enableViolin 	<= '0';
			when "11" => 
				enableHarp 		<= '0';
				enablePiano 	<= '0';
				enableClarinet <= '0';
				enableViolin 	<= '1';
		end case;
	end if;
end process enableInstrument;

resetCounter : process(clk, write, data_in)
begin
	if (rising_edge(clk)) then
		if(write = '1') then
			case data_in(3 downto 0) is
				when "1000" => counterDiode1 <= x"000"; diode1End <= '0';
				when "1001" => counterDiode2 <= x"000"; diode2End <= '0';
				when "1010" => counterDiode3 <= x"000"; diode3End <= '0';
				when "1011" => counterDiode4 <= x"000"; diode4End <= '0';
				when "1100" => counterDiode5 <= x"000"; diode5End <= '0';
				when "1101" => counterDiode6 <= x"000"; diode6End <= '0';
				when "1110" => counterDiode7 <= x"000"; diode7End <= '0';
				when "1111" => counterDiode8 <= x"000"; diode8End <= '0';
				when others => 
			end case;
		end if;
	end if;
end process resetCounter;

selectDiode : process(clk, write, data_in)
begin
	if (rising_edge(clk)) then
		if(write = '1') then
			case data_in(2 downto 0) is
				when "000" => counterDiode1 <= counterDiode1 + 1;
				when "001" => counterDiode2 <= counterDiode2 + 1;
				when "010" => counterDiode3 <= counterDiode3 + 1;
				when "011" => counterDiode4 <= counterDiode4 + 1;
				when "100" => counterDiode5 <= counterDiode5 + 1;
				when "101" => counterDiode6 <= counterDiode6 + 1;
				when "110" => counterDiode7 <= counterDiode7 + 1;
				when "111" => counterDiode8 <= counterDiode8 + 1;
				when others => 
 			end case;
		end if;
	end if;
end process selectDiode;

endEnvelope : process(clk, write, data_in)
begin
	if (rising_edge(clk)) then
		if(write = '1') then
			if(diode1End = '1') then
				data_out <= X"00000000";
			end if;
			if(diode2End = '1') then
					data_out <= X"00000000";
			end if;
			if(diode3End = '1') then
					data_out <= X"00000000";
			end if;
			if(diode4End = '1') then
					data_out <= X"00000000";
			end if;
			if(diode5End = '1') then
					data_out <= X"00000000";
			end if;
			if(diode6End = '1') then
					data_out <= X"00000000";
			end if;
			if(diode7End = '1') then
					data_out <= X"00000000";
			end if;
			if(diode8End = '1') then
					data_out <= X"00000000";
			end if;
		end if;
	end if;
end process endEnvelope;

endFlag : process(clk, write, data_in)
begin
	if (rising_edge(clk)) then
		if(write = '1') then
			if(counterDiode1 > 4094) then
				diode1End <= '1';
			end if;
			if(counterDiode2 > 4094) then
					diode2End <= '1';
			end if;
			if(counterDiode3 > 4094) then
					diode3End <= '1';
			end if;
			if(counterDiode4 > 4094) then
					diode4End <= '1';
			end if;
			if(counterDiode5 > 4094) then
					diode5End <= '1';
			end if;
			if(counterDiode6 > 4094) then
					diode6End <= '1';
			end if;
			if(counterDiode7 > 4094) then
					diode7End <= '1';
			end if;
			if(counterDiode8 > 4094) then
					diode8End <= '1';
			end if;
end if;
	end if;
end process endFlag;

end rtl;