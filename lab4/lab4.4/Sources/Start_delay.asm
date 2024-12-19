
Variables:		Section
Delay_counter:		ds.w	1

Start_delay:LDY		  #Delay_counter	; Load delay counter of 30 milliseconds
Delay:    	DEY				        ; decrement Y
            BNE		  Delay		; Branch to Delay if Y != 0
            LDAB		Port_t		; Load value of Val_T into B
            CMPB	  #0	  	; Compare Value of B with 0
            BEQ	    Loop1		; Branch to Loop1 if B = 0
            BRA		  Loop2		; Branch to Loop2