
module nios_system (
	clk_clk,
	switches_export,
	leds_export);	

	input		clk_clk;
	input	[7:0]	switches_export;
	output	[7:0]	leds_export;
endmodule
