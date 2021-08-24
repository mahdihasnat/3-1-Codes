/*
 * master.c
 *
 * Created: 8/24/2021 9:54:43 PM
 * Author : mahdi
 */ 

#include <avr/io.h>
#define F_CPU 8000000
#include <util/delay.h>
void SPI_MasterInit()
{
	DDRB |=(1<<6)|(1<<7);
	
	SPCR = 0b01010001;
}

char SPI_MasterReceive()
{
	SPDR = 0;
	while(!(SPSR&(1<<SPIF))) ;
	return SPDR;
}

int main(void)
{
    /* Replace with your application code */
	DDRA = 0xFF;
	SPI_MasterInit();
	/*
	char c = SPI_MasterReceive();
	PORTA = c;
	*/
	
    while (1) 
    {
		char c = SPI_MasterReceive();
		PORTA = c;
		_delay_ms(1);
		//if(SPSR&(1<<WCOL)) break;
    }
	
	
}

