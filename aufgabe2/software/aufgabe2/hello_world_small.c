#include"sys/alt_stdio.h"
#include"altera_avalon_pio_regs.h"
#include"system.h"
int main() {

	unsigned char ucSwitches, ucTemp;
	alt_putstr("HellofromNiosII!\n");
	ucSwitches = 0xff;

	/*Endlosschleife*/
	while (1) {
		/*Schalter einlesen*/
		ucTemp = IORD_ALTERA_AVALON_PIO_DATA(PIO_INPUT_BASE);
		if (ucTemp != ucSwitches) {
			/*LEDs setzen*/
			ucSwitches = ucTemp;
			alt_printf("Input:0x%x\n", ucSwitches);
			IOWR_ALTERA_AVALON_PIO_DATA(PIO_OUTPUT_BASE, ucSwitches | ucSwitches << 8);

		}
	};

	return 0;
}
