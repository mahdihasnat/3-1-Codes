/*
 * GccApplication1.c
 *
 * Created: 5/31/2021 4:57:40 AM
 * Author : mahdi
 */ 

// cpu frequency
#ifndef F_CPU
#define F_CPU 1000000
#endif

//---- wire connection for lcd display with 4-bit mode
#define D4 eS_PORTD4
#define D5 eS_PORTD5
#define D6 eS_PORTD6
#define D7 eS_PORTD7
#define RS eS_PORTC6
#define EN eS_PORTC7


#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include "lcd.h"
#include <stdio.h>
volatile float temperature = 0;


ISR(ADC_vect)
{
	temperature = ADCL;
	temperature = (ADCH&3) * 256.0 + temperature;
	temperature = temperature *4.5 / 1024;
	ADCSRA |= 1<<ADSC;
}

int main(void)
{
	// output line for lcd display in c6,c7 , d0-d7
	DDRD = 0xFF;
	DDRC = 0xFF;
	
	// adc configuration
	// admux = ref1 ref0 adlar mux4 mux3 mux2 mux1 mux0
	// ref = 00 -> external AREF as Vref
	// adlar = 0 if right adjusted	
	// mux = 00011
	
	ADMUX = 0b00000011;
	
	// adcsra = aden adsc adate adif adie adps2 adps1 adps0
	// aden = 1 for adc enable
	// adsc = 1 to start conversion
	// adate = 1 to auto trigering of adc by certain events
	// adif = set 1 when conversion is complete
	// adie = 1 to enable adc interrupt
	// adps = adc prescaler select bits
	
	ADCSRA = 0b10001101;	
	sei();
	ADCSRA |= 1<<ADSC;
	
	Lcd4_Init();
	while(1)
	{
		
		Lcd4_Set_Cursor(1,1);
		
		// https://startingelectronics.org/articles/atmel-AVR-8-bit/print-float-atmel-studio-7/
		//1. in project -> properties -> toolchain -> avrgnu linker -> general tick on use vprintf library
		//2. in project -> properties -> toolchain -> avrgnu linker -> misc add '-lprintf_flt' in other linker flags
		char s[14];
		snprintf(s,sizeof(s) , "Voltage: %3.2f",temperature);
		
		Lcd4_Write_String(s);
	}
}