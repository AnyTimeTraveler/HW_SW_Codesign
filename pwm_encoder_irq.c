#include <sys/alt_irq.h>
#include "system.h"

// ISR for sensor
void isr_radsensor(void* context)
{
    int tics;
	printf("interrupt occured!\n");
	//read current tic count
	tics = IORD(RADSENSENSOR_0, 0);	
	/* store tic count in variable passed as 
	* context pointer (assumed to be pointer to int) */
	*(int*)context = tics;
	//Stop engine (set to idle)
	IOWR(PWM_0_BASE, 0, 1000);
	IOWR(PWM_0_BASE, 1, 0);	 	
	IOWR(PWM_0_BASE, 2, 1000);
	IOWR(PWM_0_BASE, 3, 0);
	//isr finished, reset module
	radsensor_reset();
}

/* Reset function for sensor, needs to be
* called after isr finished serving an IRQ */
void radsensor_reset(void)
{
	int tics;
	int oldtics;
	IOWR(RADSENSOR_0_BASE, 0, 0);
	while (tic != 0)
	{
		tics= IORD(RADSENSOR_0_BASE, 0);
	}
	IOWR(RADSENSOR_0_BASE, 0, 1);
}

void isr_switches(void *context)
{
	//clear interrupt flag for switches
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(SWITCHES_BASE, 0);
	printf("Interrupt! Source: Switches\n");
}

int main(){
  int tics;
  int oldtics;
  //Register isr for sensor using HAL function
  if(0 != alt_ic_isr_register(0, //ID of Interrupt controller
							  RADSENSOR_0_IRQ, //IRQ of sensor
							  isr_radsensor,  //pointer to isr
							  (void*)&tics,   //pointer to isr context 
							  NULL)) //reserved
  {
	  printf("Error registering isr_radsensor, halted\n");
	  while(1);
  }else{
	  printf("ISR Registered for RADSENSOR_0_IRQ\n");
  }
  if(0 != alt_ic_isr_register(0, SWITCHES_IRQ, isr_switches, NULL, NULL))
  {
	printf("Error registering isr_switches, halted\n");
	while(1)
  }
  oldtics = -1;

   //setup sensor to fire in interrupt after 500 or tics
  IOWR(RADSENSOR_0_BASE, 1, 500);
  IOWR(RADSENSOR_0_BASE, 0, 3);
  
  //Set Engine to run with 75% Power
  IOWR(PWM_0_BASE, 0, 1000);
  IOWR(PWM_0_BASE, 1, 0);	 	
  IOWR(PWM_0_BASE, 2, 1000);
  IOWR(PWM_0_BASE, 3, 750);
  while(1){
	  if(oldtics != tics) 
	  {
	     printf("tics = %i\n", tics);
	     oldtics = tics;
	  }
  }
  return 0;
}
