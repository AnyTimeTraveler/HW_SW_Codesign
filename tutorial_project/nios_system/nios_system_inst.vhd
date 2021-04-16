	component nios_system is
		port (
			clk_clk             : in  std_logic                    := 'X';             -- clk
			pio_leds_export     : out std_logic_vector(7 downto 0);                    -- export
			pio_switches_export : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			reset_reset_n       : in  std_logic                    := 'X'              -- reset_n
		);
	end component nios_system;

	u0 : component nios_system
		port map (
			clk_clk             => CONNECTED_TO_clk_clk,             --          clk.clk
			pio_leds_export     => CONNECTED_TO_pio_leds_export,     --     pio_leds.export
			pio_switches_export => CONNECTED_TO_pio_switches_export, -- pio_switches.export
			reset_reset_n       => CONNECTED_TO_reset_reset_n        --        reset.reset_n
		);

