-- Quartus Prime VHDL Template
-- Binary Counter

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
	generic(
		BIT_WIDTH : integer := 32
	);
	port
	(
		clk		  : in std_ulogic;
		reset_n	  : in std_ulogic;
		enable	  : in std_ulogic;
		q		  : out std_ulogic_vector(BIT_WIDTH - 1 downto 0)
	);

end entity;

architecture rtl of counter is
begin

	process (clk,reset_n)
		variable   count		   : unsigned(BIT_WIDTH - 1 downto 0);
	begin
		if (rising_edge(clk)) then
			if reset_n = '0' then
				count := to_unsigned(0, BIT_WIDTH);
			elsif enable = '1' then
				count := count + 1;
			end if;
		end if;

		-- Output the current count
		q <= std_ulogic_vector(count);
	end process;

end rtl;
