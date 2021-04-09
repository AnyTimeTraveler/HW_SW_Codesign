/*
 * "Hello World" example: LCD module
 * inspired by http://http://ecee.colorado.edu/
 */

/* NewLib and POSIX */
#include <stdio.h>
#include <unistd.h>

/** SoPC specific hardware description */
#include "system.h"
#include "altera_avalon_timer.h"
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_lcd_16207_regs.h"

#define LCD_WR_COMMAND_REG 0
#define LCD_RD_STATUS_REG 1
#define LCD_WR_DATA_REG 2
#define LCD_RD_DATA_REG 3

int lcd_init(void);
int lcd_test(void);


int main()
{
	/* goes to STDOUT -> JTAG-UART*/  
printf("Hello from Nios II!\n");

  lcd_init();
  lcd_test();
  
  printf("Done.\n");
  while(1);

  return 0;
}

int lcd_init( void) {
	usleep(15000); /* Wait for more than 15 ms before init */
	/* Set function code four times -- 8-bit, 2 line, 5x7 mode */
	IOWR(MYLCD_BASE, LCD_WR_COMMAND_REG, 0x38);
	usleep(4100); /* Wait for more than 4.1 ms */
	IOWR(MYLCD_BASE, LCD_WR_COMMAND_REG, 0x38);
	usleep(100);
	/* Wait for more than 100 us */
	IOWR(MYLCD_BASE, LCD_WR_COMMAND_REG, 0x38);
	usleep(5000); /* Wait for more than 100 us */
	IOWR(MYLCD_BASE, LCD_WR_COMMAND_REG, 0x38);
	usleep(100); /* Wait for more than 100 us*/

	/* Set display to OFF*/
	IOWR(MYLCD_BASE, LCD_WR_COMMAND_REG, 0x08);
	usleep(100);
	/* Set display to ON */
	IOWR(MYLCD_BASE, LCD_WR_COMMAND_REG, 0x0C);
	usleep(100);
	/* Set Entry Mode -- Cursor increment, display doesn't shift */
	IOWR(MYLCD_BASE, LCD_WR_COMMAND_REG, 0x06);
	usleep(100);
	/* Set the Cursor to the home position */
	IOWR(MYLCD_BASE, LCD_WR_COMMAND_REG, 0x02);
	usleep(2000);
	/* Display clear */
	IOWR(MYLCD_BASE, LCD_WR_COMMAND_REG, 0x01);
	usleep(2000);

	return(0);
}


int lcd_test( void) {
	int i;
	char message[] = "Hello World...  "; char done[] = "Done!           ";

	/* Write a simple message on the first line. */
	for(i = 0; i < 16; i++) {
		IOWR(MYLCD_BASE, LCD_WR_DATA_REG,message[i]);
		usleep(100);
	}
	/* Count along the bottom row */
	/* Set address */
	IOWR(MYLCD_BASE, LCD_WR_COMMAND_REG,0xC0);
	usleep(1000);
	/* Display count */
	for (i = 0; i < 10; i++) {
		IOWR(MYLCD_BASE, LCD_WR_DATA_REG, (char)(i+0x30) );
	usleep(100000); /* Wait 0.1 sec */
	}
	/* Write final message on first line. */
	/* Set address */
	IOWR(MYLCD_BASE, LCD_WR_COMMAND_REG,0x80);
	usleep(1000);
	/* Write data */
	for(i = 0; i < 16; i++) {
		IOWR(MYLCD_BASE, LCD_WR_DATA_REG, done[i]);
		usleep(100);
	}
	return(0);
	}

