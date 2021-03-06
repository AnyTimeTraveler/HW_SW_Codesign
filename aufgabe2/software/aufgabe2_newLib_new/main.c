/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include"system.h"
#include <stdint.h>
#include <stdlib.h>
#include"altera_avalon_pio_regs.h"

const uint32_t MEM_1MB = 1024 * 1024;
const uint32_t MEM_SIZE = 16 * 1024 * 1024;

void* pointers[7];

void show_allocated();

int main() {
	printf("Hello from Nios II!\n");

	for (int i = 0; i < 7; ++i) {
		pointers[i] = 0;
	}

	// 2.3.1
	for (int i = 0; i < 7; ++i) {
		pointers[i] = malloc(MEM_SIZE);
		printf("Address %d: %p\n", i, pointers[i]);
		show_allocated();
	}

	// 2.3.2
	for (int i = 0; i < 7; i += 2) {
		free(pointers[i]);
		pointers[i] = 0;
		show_allocated();
	}

	void * big_pointer = malloc(2 * MEM_SIZE);
	printf("Big pointer: %p\n", big_pointer);

	// 2.3.3

	uint32_t* write_address = pointers[5];
	uint32_t chunks = 2; // (1. 32 MByte)
	//uint32_t chunks = 4; // (2. 64 MByte)
	uint32_t write_count = chunks * MEM_SIZE / 4;
	write_address += (MEM_SIZE / 4) * 7 / 3;

	printf("Start address: %p\n", write_address);
	for (uint32_t i = 0; i < write_count; ++i) {
		*write_address = i;
		if (*write_address != i) {
			printf("Write failed at:\n");
			unsigned long long x = write_address;
			printf("%llu\n", x);
			break;
		}
		write_address += 1;
	}
	printf("End address: %p\n", write_address - 1);

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
