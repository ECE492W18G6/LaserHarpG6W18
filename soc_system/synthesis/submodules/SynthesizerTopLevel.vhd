-- Author: Peter Crinklaw
-- Slight modifications by: Adam Narten

--Top Level file for Sythesizer component. Hides avalon interface specs
--from the main Synthesizer component.
-- SynthesizerTopLevel.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_arith.all;
use IEEE.numeric_bit.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_signed.all;
use IEEE.std_logic_unsigned.all;
use work.SynthesizerPackage.all;	

entity SynthesizerTopLevel is
	port (
		aso_data_audio_out                    : out std_logic_vector(31 downto 0);                    -- avalon_streaming_source.data
		aso_valid_audio_out                   : out std_logic;                                        --                        .valid
		csi_clk50M                            : in  std_logic                     := '0';             --              clock_sink.clk
		csi_clk32k                            : in  std_logic                     := '0';             --            clock_sink_1.clk
		avs_write_n_phase_increments_voice0   : in  std_logic                     := '0';             -- phase_increments_voice0.write_n
		avs_writedata_phase_increments_voice0 : in  std_logic_vector(31 downto 0) := (others => '0'); --                        .writedata
		reset_n                               : in  std_logic                     := '0'              --                   reset.reset_n
	);
end entity SynthesizerTopLevel;

architecture additionalSynthesizer of SynthesizerTopLevel is

	signal phase_increments_s	: PHASE_INCS;	

	component Synthesizer is
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
	end component;
		
begin


	read_phase_increment0: process(avs_write_n_phase_increments_voice0)
	begin
		if falling_edge(avs_write_n_phase_increments_voice0) then
				phase_increments_s(0)(15 downto 0) <=   avs_writedata_phase_increments_voice0(15 downto 0);
		end if;
	end process read_phase_increment0;
	
	
	
	laserHarpSynthesizer: Synthesizer
	port map(
		clk => csi_clk32k,
		reset_n => reset_n,
		phase_increments => phase_increments_s,
		audio_output => aso_data_audio_out(31 downto 16),
		audio_output_valid => aso_valid_audio_out
	);
	
end additionalSynthesizer;