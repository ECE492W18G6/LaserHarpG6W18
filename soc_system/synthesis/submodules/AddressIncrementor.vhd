-- Original Author	: Bharathwaj Muthuswamy
-- Additional Author : Peter Crinklaw
-- Based on version by	: Eric Lunty, Kyle Brooks, Peter Roland
-- http://www.ece.ualberta.ca/~elliott/ece492/appnotes/2012w/Audio_Codec_G2/waveform_gen.vhd

--Keeps track of the current address for a wave, and increments it according to
--phase_inc.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.SynthesizerPackage.all;

entity AddressIncrementor is
	port (
	  -- system signals
	  clk         	: in  std_logic;
	  reset_n       : in  std_logic;
	  
	  -- NCO frequency control
	  phase_inc   	: in  std_logic_vector(15 downto 0);

	  -- Output waveforms
	  lut_address	: out std_logic_vector(11 downto 0)
	  );
end entity;


architecture rtl of AddressIncrementor is



	signal  phase_acc     : std_logic_vector(15 downto 0) := x"0000";
	signal  lut_addr_reg  : std_logic_vector(11 downto 0);


	begin


	--------------------------------------------------------------------------
	-- Phase accumulator increments by 'phase_inc' every clock cycle        --
	-- Output frequency determined by formula: Phase_inc = (Fout/Fclk)*2^32 --
	-- E.g. Fout = 36MHz, Fclk = 100MHz,  Phase_inc = 36*2^32/100           --
	-- Frequency resolution is 100MHz/2^32 = 0.00233Hz                      --
	--------------------------------------------------------------------------
		

	phase_acc_reg: process(clk, reset_n)
	begin
	  if reset_n = '0' then
			phase_acc <= (others => '0');

	  elsif clk'event and clk = '1' then
		--if en = '1' then
			phase_acc <= unsigned(phase_acc) + unsigned(phase_inc);  
		--end if;
	  end if;
	end process phase_acc_reg;



	---------------------------------------------------------------------
	-- use top 12-bits of phase accumulator to address the SIN LUT --
	---------------------------------------------------------------------

	lut_address <= phase_acc(15 downto 4);


	---------------------------------
	-- Hide the latency of the LUT --
	---------------------------------

	-- delay_regs: process(clk)
	-- begin
	  -- if clk'event and clk = '1' then
		-- --if en = '1' then
			-- lut_addr_reg <= lut_addr;
		-- --end if;
	  -- end if;
	-- end process delay_regs;




end rtl;