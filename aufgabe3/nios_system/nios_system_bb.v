
module nios_system (
	clk_clk,
	pio_leds_export,
	pio_switches_export,
	reset_reset_n,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	rs232_RXD,
	rs232_TXD,
	lcd_RS,
	lcd_RW,
	lcd_data,
	lcd_E);	

	input		clk_clk;
	output	[15:0]	pio_leds_export;
	input	[7:0]	pio_switches_export;
	input		reset_reset_n;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[31:0]	sdram_wire_dq;
	output	[3:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	input		rs232_RXD;
	output		rs232_TXD;
	output		lcd_RS;
	output		lcd_RW;
	inout	[7:0]	lcd_data;
	output		lcd_E;
endmodule
