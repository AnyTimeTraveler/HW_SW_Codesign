	component nios_system is
		port (
			clk_clk         : in  std_logic                    := 'X';             -- clk
			switches_export : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			leds_export     : out std_logic_vector(7 downto 0)                     -- export
		);
	end component nios_system;

	u0 : component nios_system
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --      clk.clk
			switches_export => CONNECTED_TO_switches_export, -- switches.export
			leds_export     => CONNECTED_TO_leds_export      --     leds.export
		);

