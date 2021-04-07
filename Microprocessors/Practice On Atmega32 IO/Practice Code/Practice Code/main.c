/*
 * Practice Code.c
 *
 * Created: 4/4/2021 2:37:32 PM
 * Author : mahdi
 */ 

#include <avr/io.h>


int main(void)
{
    /* Replace with your application code */
	DDRC = 0b00001001;
	DDRB = 0b00000000;
	unsigned char out = 0;
	PORTC = out;
    while (1) 
    {
		unsigned char in = PINB;
		if((in & 0b10000000) == 0) // B7 as active low push buttton
		{
			unsigned char count = 0;
			count=0;
			count+=(in>>0)&1;
			count+=(in>>2)&1;
			count+=(in>>4)&1;
			out =  (count&1) | (((count>>1)&1) << 3);
			PORTC = out;
		}
    }
}

