/*
 * "Hello World" example: LCD module
 * inspired by http://http://ecee.colorado.edu/
 */

/* NewLib and POSIX */
#include <stdio.h>
#include <stdint.h>
#include <unistd.h>

/** SoPC specific hardware description */
#include "system.h"
#include "io.h"
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_lcd_16207_regs.h"
#include "altera_avalon_lcd_16207.h"

#define LCD_WR_COMMAND_REG 0
#define LCD_RD_STATUS_REG 1
#define LCD_WR_DATA_REG 2
#define LCD_RD_DATA_REG 3

int lcd_init(void);
int lcd_test(void);

void lcd_print(uint32_t sys_id, uint32_t sys_timestamp);
void uart_print(uint32_t sys_id, uint32_t sys_timestamp);

int main() {
	/* goes to STDOUT -> JTAG-UART*/
	printf("Hello from Nios II!\n");

//	lcd_init();
//	lcd_test();

// 3 Systeminformationen
	printf("Read:  ");
	uint32_t sys_id = IORD_32DIRECT(SYSID_QSYS_BASE, 0);
	uint32_t sys_timestamp = IORD_32DIRECT(SYSID_QSYS_BASE, 4);
	printf("Done!\n");

	printf("SysID: %lx\n", sys_id);
	printf("SysTS: %lx\n", sys_timestamp);

	// 4 Implementation LCD
	printf("LCD :  ");
	lcd_print(sys_id, sys_timestamp);
	printf("Done!\n");

	// 5 Implementation UART
	printf("UART:  ");
	uart_print(sys_id, sys_timestamp);
	printf("Done!\n");

	printf("\n\nSleeping now...\n");
	while (1) {

	}
	return 0;
}

int lcd_init(void) {
	usleep(15000); /* Wait for more than 15 ms before init */
	/* Set function code four times -- 8-bit, 2 line, 5x7 mode */
	IOWR(LCD_BASE, LCD_WR_COMMAND_REG, 0x38);
	usleep(4100); /* Wait for more than 4.1 ms */
	IOWR(LCD_BASE, LCD_WR_COMMAND_REG, 0x38);
	usleep(100);
	/* Wait for more than 100 us */
	IOWR(LCD_BASE, LCD_WR_COMMAND_REG, 0x38);
	usleep(5000); /* Wait for more than 100 us */
	IOWR(LCD_BASE, LCD_WR_COMMAND_REG, 0x38);
	usleep(100); /* Wait for more than 100 us*/

	/* Set display to OFF*/
	IOWR(LCD_BASE, LCD_WR_COMMAND_REG, 0x08);
	usleep(100);
	/* Set display to ON */
	IOWR(LCD_BASE, LCD_WR_COMMAND_REG, 0x0C);
	usleep(100);
	/* Set Entry Mode -- Cursor increment, display doesn't shift */
	IOWR(LCD_BASE, LCD_WR_COMMAND_REG, 0x06);
	usleep(100);
	/* Set the Cursor to the home position */
	IOWR(LCD_BASE, LCD_WR_COMMAND_REG, 0x02);
	usleep(2000);
	/* Display clear */
	IOWR(LCD_BASE, LCD_WR_COMMAND_REG, 0x01);
	usleep(2000);

	return (0);
}

int lcd_test(void) {
	int i;
	char message[] = "Hello World...  ";
	char done[] = "Done!           ";

	/* Write a simple message on the first line. */
	for (i = 0; i < 16; i++) {
		IOWR(LCD_BASE, LCD_WR_DATA_REG, message[i]);
		usleep(100);
	}
	/* Count along the bottom row */
	/* Set address */
	IOWR(LCD_BASE, LCD_WR_COMMAND_REG, 0xC0);
	usleep(1000);
	/* Display count */
	for (i = 0; i < 10; i++) {
		IOWR(LCD_BASE, LCD_WR_DATA_REG, (char )(i + 0x30));
		usleep(100000); /* Wait 0.1 sec */
	}
	/* Write final message on first line. */
	/* Set address */
	IOWR(LCD_BASE, LCD_WR_COMMAND_REG, 0x80);
	usleep(1000);
	/* Write data */
	for (i = 0; i < 16; i++) {
		IOWR(LCD_BASE, LCD_WR_DATA_REG, done[i]);
		usleep(100);
	}
	return (0);
}

void lcd_print(uint32_t sys_id, uint32_t sys_timestamp) {
	FILE * lcd = fopen(LCD_NAME, "w");

	if (lcd) {
		fprintf(lcd, "ID:   0x%lx\n", sys_id);
		fprintf(lcd, "Time: 0x%lx\n", sys_timestamp);
		fclose(lcd);
	} else {
		printf("Couldn't open LCD!\n");
	}

}

void uart_print(uint32_t sys_id, uint32_t sys_timestamp) {
	FILE * uart = fopen(RS232_NAME, "w");

	if (uart) {
		char data[32];
		for (int i = 0; i < 32; ++i) {
			data[i] = 15;
		}
		fwrite(&data, sizeof(char), 32, uart);

//		fprintf(uart, "01234567890");
		fprintf(uart, "ID:   0x%lx\n", sys_id);
		fprintf(uart, "Time: 0x%lx\n", sys_timestamp);
		fflush(uart);
		fclose(uart);
	} else {
		printf("Couldn't open UART!\n");
	}
}
