/*
 * slave.c
 *
 * Created: 8/24/2021 10:05:28 PM
 * Author : mahdi
 */ 
#define F_CPU 1000000
#include <util/delay.h>

#include <avr/io.h>
#include <avr/interrupt.h>
ISR(SPI_STC_vect)
{
	SPDR = PINA;
}

void SPI_SlaveInit()
{
	DDRB |= (1<<6); // MISO
	SPCR = 0b11000001;
}

int main(void)
{
    /* Replace with your application code */
	
	DDRA = 0x00;
	DDRC = 0xFF;
	SPI_SlaveInit();
	//SPDR = PINA;
	sei();
	
    while (1) 
    {
		;
    }
}

