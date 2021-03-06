#include"system.h"
#include "sys/alt_stdio.h"
#include <stdint.h>
#include <stdlib.h>
#include"altera_avalon_pio_regs.h"

const uint32_t MEM_SIZE = 16 * 1024 * 1024;

void* pointers[7];

void show_allocated();

int main() {
	alt_putstr("Hello from Nios II!\n");

	for (int i = 0; i < 7; ++i) {
		pointers[i] = 0;
	}

	// 2.3.1
	for (int i = 0; i < 7; ++i) {
		pointers[i] = malloc(MEM_SIZE);
		alt_printf("Address %x: %x\n", i, pointers[i]);
		show_allocated();
	}

	// 2.3.2
	for (int i = 0; i < 7; i += 2) {
		free(pointers[i]);
		pointers[i] = 0;
		show_allocated();
	}

	void * big_pointer = malloc(2 * MEM_SIZE);
	alt_printf("Big pointer: %x\n", big_pointer);

	// 2.3.3

	uint8_t* write_address = pointers[5];
	uint32_t chunks = 2; // (1. 32 MByte)
	//uint32_t chunks = 4; // (2. 64 MByte)

	alt_printf("Start address: %x\n", write_address);
	for (uint32_t i = 0; i < chunks * MEM_SIZE; ++i) {
		*write_address = i;
		if(*write_address != i){
			alt_printf("Write failed at %x\n", write_address);
		}
		write_address += 1;
	}
	alt_printf("End address: %x\n", write_address-1);




	/* Event loop never exits. */
	while (1) {
		// noop
	}

	return 0;
}

void show_allocated() {
	uint8_t lights = 0;

	for (int i = 0; i < 7; ++i) {
		if (pointers[i] != 0) {
			lights |= 1 << (7 - i);
		}
	}

	IOWR_ALTERA_AVALON_PIO_DATA(PIO_OUTPUT_BASE, lights);
}

