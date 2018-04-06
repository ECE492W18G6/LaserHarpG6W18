--------------------------------------------------------------------------------------------------------
-- Original Author : Adam Narten																								--
-- Date created: April 3, 2018																								--
-- This program is the file for the custom Photodiodes component for the Winter18 Laser Harp in ECE492--
--------------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Photodiodes is
	port (
		avalon_slave_read_n   : in  std_logic                     := '0'; -- avalon_slave.read_n
		avalon_slave_readdata : out std_logic_vector(7 downto 0);        --             .readdata
		conduit_end_0		    : in  std_logic                     := '0';
		conduit_end_1		    : in  std_logic                     := '0';
		conduit_end_2		    : in  std_logic                     := '0';
		conduit_end_3		    : in  std_logic                     := '0';
		conduit_end_4		    : in  std_logic                     := '0';
		conduit_end_5		    : in  std_logic                     := '0';
		conduit_end_6		    : in  std_logic                     := '0';
		conduit_end_7		    : in  std_logic                     := '0';
		clk                   : in  std_logic                     := '0'; --        clock.clk
		reset_n               : in  std_logic                     := '0'  --        reset.reset_n
	);
end entity Photodiodes;

architecture rtl of Photodiodes is
begin
	process(reset_n, clk, conduit_end_0, conduit_end_1, conduit_end_2, conduit_end_3,
				conduit_end_4, conduit_end_5, conduit_end_6, conduit_end_7) is
	
	begin
	if (reset_n = '0') then
		avalon_slave_readdata <= x"00";
	elsif (rising_edge(clk)) then
		if (conduit_end_0 = '0') then
			avalon_slave_readdata(0) <= '1';
		else 
			avalon_slave_readdata(0) <= '0';
		end if;
		if (conduit_end_1 = '0') then
			avalon_slave_readdata(1) <= '1';
		else 
			avalon_slave_readdata(1) <= '0';
		end if;
		if (conduit_end_2 = '0') then
			avalon_slave_readdata(2) <= '1';
		else 
			avalon_slave_readdata(2) <= '0';
		end if;
		if (conduit_end_3 = '0') then
			avalon_slave_readdata(3) <= '1';
		else 
			avalon_slave_readdata(3) <= '0';
		end if;
		if (conduit_end_4 = '0') then
			avalon_slave_readdata(4) <= '1';
		else 
			avalon_slave_readdata(4) <= '0';
		end if;
		if (conduit_end_5 = '0') then
			avalon_slave_readdata(5) <= '1';
		else 
			avalon_slave_readdata(5) <= '0';
		end if;
		if (conduit_end_6 = '0') then
			avalon_slave_readdata(6) <= '1';
		else 
			avalon_slave_readdata(6) <= '0';
		end if;
		if (conduit_end_7 = '0') then
			avalon_slave_readdata(7) <= '1';
		else 
			avalon_slave_readdata(7) <= '0';
		end if;
	end if;
	end process ;
	

end architecture rtl; -- of Photodiodes
