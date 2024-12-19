/*
  	C file to control speaker via SPI port.
          Written By: Jonathon Murphy
          email:  jonathonpmurphy@gmail.com
          Used For: ECE362 SP12 Lab 6.2


*/

#include <hidef.h>                  /* common defines and macros */
#include "derivative.h"             /* derivative-specific definitions */
#include "SendsChr.h"

int timer_count;		                //variable to hold RTI iterations

void SendInit()
{
    SPICR1 = 0x52;                  //enable SPI port and set to master
    SPICR2 = 0x00;                  
    SPIBR = 0x76;                   //set baud rate to 24.4kHz (almost the slowest Baud Rate for 9s12e128 processor)

}     
    
void SendsChr(char OutChar, int dummy)
{
    timer_count = 0;
    
    while(!(SPISR&0xA0));	          //wait for data register to be clear and ready
    SPIDR = 0x11;		                //clear SPI register by shifting data twice
    while(!(SPISR&0xA0));
    SPIDR = 0x11;
    while(!(SPISR&0xA0));
    SPIDR = OutChar;	              //write desired data to SPI port
    
    while (timer_count<434);	      //delay using RTI to allow the tone to be heard for .5 S (1.152 mS * 434 ~= .5 S)
}

void SpiStop()
{
	SendsChr(0, 0);	                  //clear data register for SPI port
	SPICR1 = 0;                       //turn off SPI
}      

void Init_RTI()
{
	 CRGINT = 0x80;    		            //enable rti
	 RTICTL = 0x18;    		            //set interrupt frequency(1.152 mS)
	 #asm
 		cli	         	                  //clear I bit, enabling interrupts
	 #endasm
}
#pragma CODE_SEG NON_BANKED 
void interrupt rti_ser(void)
{
	timer_count++;		                //increment RTI counter, tracking time elapsed
	CRGFLG = 0x80;		                //clear RTI flag, allowing further interrupts
}