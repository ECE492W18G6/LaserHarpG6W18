--------------------------------------------------------------------------------------------------------------------------
-- Original Authors : Adam Narten											--
-- Date created:  March 4, 2018												--
--															--
-- Structure for creating a modelsim testbench was referenced from NANDLAND						--
-- https://www.nandland.com/vhdl/tutorials/tutorial-modelsim-simulation-walkthrough.html				--
--															--
-- This program takes a frequency of 1 and steps it through a phase accumulator in the synthesizer.		 	--
-- It makes sure the correct sine wave values are getting ouputted from the lookup table.				--
-- 															--
--------------------------------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
 
entity EnvelopeController_tb is
end EnvelopeController_tb;
 
architecture behave of EnvelopeController_tb is
	signal clk_SIG	: std_logic := '0';
	signal reset_SIG	: std_logic := '0';
	signal write_SIG	: std_logic := '0';
	signal read_SIG	: std_logic := '0';
	signal data_in 	: std_logic_vector(31 downto 0) := (others => '0');
	signal data_out	: std_logic_vector(31 downto 0);
   
  component EnvelopeController is
	port(
	clk 		: in std_logic; 
	reset 		: in std_logic; 
	write		: in std_logic; 
	read		: in std_logic; 
	data_in : in std_logic_vector(31 downto 0); 
	data_out : out std_logic_vector(31 downto 0));
  end component EnvelopeController;
   
begin
   
  Cont : EnvelopeController
    port map (
	clk	=> clk_SIG,
	reset	=> reset_SIG,
	write	=> write_SIG,
	read	=> read_SIG,
	data_in	=> data_in,
	data_out	=> data_out
	);
 
  process is
  begin
	-- Reset and initialize clock to 0;
	reset_SIG <= '1';
	wait for 10 ns;
	reset_SIG <= '0';
	clk_SIG <= '0';
	wait for 10 ns;
	-- initialize frequency and enable write signal
	data_in <= x"00000010";
	write_SIG <= '1';
	-- toggle clock
	for I in 0 to 4096 loop
		clk_SIG <= '1'; -- transition on rising edge
		wait for 5 ns;
		clk_SIG <= '0';
		wait for 5 ns;
	end loop;
  end process;
     
end behave;