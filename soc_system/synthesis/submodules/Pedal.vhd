-----------------------------------------------------------------------------------------------------
-- Original Author : Adam Narten																							--
-- Date created: April 3, 2018																							--
-- This program is the file for the custom pedal component for the Winter18 Laser Harp in ECE492.  --
-----------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Pedal is
	port (
		avalon_slave_read_n   : in  std_logic                     := '0'; -- avalon_slave.read_n
		avalon_slave_readdata : out std_logic_vector(7 downto 0);        --             .readdata
		conduit_end				 : in  std_logic                     := '0'; --  conduit_end.export
		clk                   : in  std_logic                     := '0'; --        clock.clk
		reset_n               : in  std_logic                     := '0'  --        reset.reset_n
	);
end entity Pedal;

architecture rtl of Pedal is
begin
	process(clk, reset_n, conduit_end) is
	begin
	if (reset_n = '0') then
		avalon_slave_readdata <= x"00";
	elsif (rising_edge(clk)) then
		if (conduit_end = '1') then
			avalon_slave_readdata <= x"FF"; -- nonzero
		else
			avalon_slave_readdata <= x"00";
		end if;
	end if;
	end process;
end architecture rtl;