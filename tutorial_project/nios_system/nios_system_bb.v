
module nios_system (
	clk_clk,
	pio_leds_export,
	pio_switches_export,
	reset_reset_n);	

	input		clk_clk;
	output	[7:0]	pio_leds_export;
	input	[7:0]	pio_switches_export;
	input		reset_reset_n;
endmodule
