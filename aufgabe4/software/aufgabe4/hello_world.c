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
#include <stdint.h>
#include "system.h"
#include "altera_avalon_performance_counter.h"

typedef uint32_t smuad_t(uint32_t, uint32_t);

// Funktionsdefinitionen
uint32_t smuad_ci(uint32_t a, uint32_t b);
uint32_t smuad_cpu(uint32_t a, uint32_t b);
uint32_t smuad_cp(uint32_t a, uint32_t b);
void test_performance_all(uint32_t repeat_count);
void test_performance(uint8_t perf_id, uint32_t repeat_count, char* name, smuad_t smuad_impl);

// Test-Werte zum starten der Berechnungen
const uint32_t VALUE_A = 0x01010202;
const uint32_t VALUE_B = 0x00300004;

int main() {
	printf("Hello from Nios II!\n");

	// Groessen der Test Iterationen
	uint32_t runs[] = { 1, 10, 10000, 100000 };

	for (uint32_t i = 0; i < sizeof(runs) / sizeof(runs[0]); i++) {
		printf("\n** Test %lu: %lu repeats  **\n\n", i + 1, runs[i]);
		test_performance_all(runs[i]);
		printf("\n** Test END **\n\n\n");
	}

	// Loop  never  exits.
	while (1) {
		// noop
	}

	return 0;
}

void test_performance_all(uint32_t repeat_count) {
	PERF_RESET(PERFORMANCE_COUNTER_BASE);
	PERF_START_MEASURING(PERFORMANCE_COUNTER_BASE);

	test_performance(1, repeat_count, "CI ", &smuad_ci);
	test_performance(2, repeat_count, "CPU", &smuad_cpu);
	test_performance(3, repeat_count, "CP ", &smuad_cp);

	PERF_STOP_MEASURING(PERFORMANCE_COUNTER_BASE);
	printf("\n");
	perf_print_formatted_report((void*) PERFORMANCE_COUNTER_BASE,
	ALT_CPU_CPU_FREQ, 3, "Nios -CI", "Nios -CPU", "Nios -CP");
}

void test_performance(uint8_t perf_id, uint32_t repeat_count, char* name, smuad_t smuad_impl) {
	uint32_t result = VALUE_A;

	PERF_BEGIN(PERFORMANCE_COUNTER_BASE, perf_id);
	for (uint32_t i = 0; i < repeat_count; i++) {
		result = smuad_impl(VALUE_B + i, result);
	}
	PERF_END(PERFORMANCE_COUNTER_BASE, perf_id);

	printf("%s Result after %lu runs: %lu\n", name, repeat_count, result);
}


inline uint32_t smuad_ci(uint32_t a, uint32_t b) {
	return ALT_CI_SMUAD_CI_0(a, b);
}


inline uint32_t smuad_cpu(uint32_t a, uint32_t b) {
	union MyInt {
		uint32_t all;
		struct {
			uint16_t top;
			uint16_t bot;
		};
	} r0, r1;

	r0.all = a;
	r1.all = b;

	return (r0.top * r1.top) + (r0.bot * r1.bot);
}

inline uint32_t smuad_cp(uint32_t a, uint32_t b) {
	IOWR_32DIRECT(SMUAD_CP_BASE, 0, a);
	IOWR_32DIRECT(SMUAD_CP_BASE, 4, b);
	return IORD_32DIRECT(SMUAD_CP_BASE, 0);
}
