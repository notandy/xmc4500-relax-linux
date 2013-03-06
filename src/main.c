/* main.c */
#include <stdint.h>
#include <XMC4500.h>
#include <arm_math.h>
#include "GPIO.h"

volatile uint32_t usTicks = 0;
volatile float32_t curPos = .0;

static const uint32_t DURATION = 15;

void SysTick_Handler(void) {
	usTicks++;

	curPos += 0.001;
	if(curPos > PI)
		curPos = 0;
}

void delay_us(uint32_t us) {
	uint32_t now = usTicks;
	while ((usTicks-now) < us)
		;
}

int main(void) {
	int dutycycle;
	P1_1_set_mode(OUTPUT_PP_GP);
	P1_1_set_driver_strength(STRONG);
	SysTick_Config(SystemCoreClock/1000);

	while(1)
	{
		dutycycle = (int)(DURATION*arm_sin_f32(curPos));

		P1_1_toggle(); /* On */
		delay_us(DURATION - dutycycle);
		P1_1_toggle(); /* Off */
		delay_us(dutycycle);

	}
}
