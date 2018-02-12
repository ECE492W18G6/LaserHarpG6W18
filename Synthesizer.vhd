library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.std_logic_textio.all;
    use IEEE.std_logic_arith.all;
    use IEEE.numeric_bit.all;
    use IEEE.numeric_std.all;
    use IEEE.std_logic_signed.all;
    use IEEE.std_logic_unsigned.all;
	
use work.SynthesizerPackage.all;

entity Synthesizer is
	port (
	-- system signals
	clk         : in  std_logic;
	reset_n       : in  std_logic;
  
	-- Frequency control
	--Bottom 16 bits are for first oscillator, next 16 are for second, next 16 are for third
	phase_increments   		: in  PHASE_INCS;	
	audio_output			: out std_logic_vector(15 downto 0);
	audio_output_valid		: out std_logic
	);
end Synthesizer;

architecture synthesizer of Synthesizer is

	signal target_lut_addresses 	: LUT_ADDRESSES;
	signal audioData		: WAVE_ARRAY;

	component AddressIncrementor is
	port (
	  -- system signals
	  clk         	: in  std_logic;
	  reset_n       : in  std_logic;
	  
	  -- NCO frequency control
	  phase_inc   	: in  std_logic_vector(15 downto 0);

	  -- Output waveforms
	  lut_address	: out std_logic_vector(11 downto 0)
	  );
	end component;
	
	component SinLut is
		port (
			clk      : in  std_logic;
			
			--Address input
			address  : in LUT_ADDRESSES;
			
			--Sine output
			audioData : out WAVE_ARRAY
		);
	end component;

	begin
	
	anAddressIncrementor: AddressIncrementor
		port map(
			clk => clk,
			reset_n => reset_n,
			phase_inc => phase_increments(0)(15 downto 0),
			lut_address => target_lut_addresses(0)
		);
		
	aSinLut: SinLut
		port map(
			clk => clk,
			address => target_lut_addresses,
			audioData => audioData
		);	

	send_output: process(clk, reset_n)
	begin
		if rising_edge(clk) then
			audio_output <= audioData(0);
		end if;
	end process send_output;

	audio_output_valid <= '1';	

end synthesizer;