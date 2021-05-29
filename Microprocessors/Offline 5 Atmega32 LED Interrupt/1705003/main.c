/*
 * latest.c
 *
 * Created: 4/9/2021 12:27:32 PM
 * Author : mahdi
 */ 

#define F_CPU 1000000

#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

#define SetBit(variable , position)  variable = (variable ) | (1<<((position)))
//#define UnSetBit(variable , position )  

#define COLUMN_PORT  PORTA
#define ROW_PORT  PORTD

#define  TOTAL_ROW 8
#define  TOTAL_COLUMN 8

#define STATIC_STATE 0
#define DYNAMIC_STATE 1

#define RightRotateColumn(x) ((x<<1) | (x>>(TOTAL_COLUMN-1)))
#define LeftRotateColumn(x) ((x>>1)|((x&1) << (TOTAL_COLUMN-1)))

uint8_t led_matrix[TOTAL_ROW];


volatile uint8_t state  = STATIC_STATE;

ISR(INT2_vect)
{
	state ^= 1;
}


inline void print_led()
{
	
	for(uint8_t row = 0; row < TOTAL_ROW ; row ++)
	{
		ROW_PORT = ~(1<<row);
		COLUMN_PORT = led_matrix[row];
	}
}


int main(void)
{
	MCUCSR |= (1<<ISC2);
	GICR |= (1<<INT2);
	sei();
	DDRB = 0x00;
	DDRA = 0xFF;
	DDRD = 0xFF;
	led_matrix[0]= 0b00000000;
	led_matrix[1]= 0b00000110;
	led_matrix[2]= 0b00000110;
	led_matrix[3]= 0b00000110;
	led_matrix[4]= 0b00000110;
	led_matrix[5]= 0b00000110;
	led_matrix[6]= 0b11111110;
	led_matrix[7]= 0b11111110;
    /* Replace with your application code */
    while (1) 
    {	
		
		
		if(state == STATIC_STATE)
		{
			
		}
		else 
		{
			for(uint8_t row = 0 ; row < TOTAL_ROW ; row++)
				led_matrix[row] = RightRotateColumn(led_matrix[row]);
		}
		for(int i=0;i<2000;i++)
			print_led();
		//_delay_ms(5);
    }
}

