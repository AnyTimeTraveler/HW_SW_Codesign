	nios_system u0 (
		.clk_clk             (<connected-to-clk_clk>),             //          clk.clk
		.pio_leds_export     (<connected-to-pio_leds_export>),     //     pio_leds.export
		.pio_switches_export (<connected-to-pio_switches_export>), // pio_switches.export
		.reset_reset_n       (<connected-to-reset_reset_n>),       //        reset.reset_n
		.sdram_wire_addr     (<connected-to-sdram_wire_addr>),     //   sdram_wire.addr
		.sdram_wire_ba       (<connected-to-sdram_wire_ba>),       //             .ba
		.sdram_wire_cas_n    (<connected-to-sdram_wire_cas_n>),    //             .cas_n
		.sdram_wire_cke      (<connected-to-sdram_wire_cke>),      //             .cke
		.sdram_wire_cs_n     (<connected-to-sdram_wire_cs_n>),     //             .cs_n
		.sdram_wire_dq       (<connected-to-sdram_wire_dq>),       //             .dq
		.sdram_wire_dqm      (<connected-to-sdram_wire_dqm>),      //             .dqm
		.sdram_wire_ras_n    (<connected-to-sdram_wire_ras_n>),    //             .ras_n
		.sdram_wire_we_n     (<connected-to-sdram_wire_we_n>),     //             .we_n
		.rs232_RXD           (<connected-to-rs232_RXD>),           //        rs232.RXD
		.rs232_TXD           (<connected-to-rs232_TXD>),           //             .TXD
		.lcd_RS              (<connected-to-lcd_RS>),              //          lcd.RS
		.lcd_RW              (<connected-to-lcd_RW>),              //             .RW
		.lcd_data            (<connected-to-lcd_data>),            //             .data
		.lcd_E               (<connected-to-lcd_E>)                //             .E
	);

