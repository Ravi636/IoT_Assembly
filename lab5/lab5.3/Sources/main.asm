;**************************************************************
;* This stationery serves as the framework for a              *
;* user application. For a more comprehensive program that    *
;* demonstrates the more advanced functionality of this       *
;* processor, please see the demonstration applications       *
;* located in the examples subdirectory of the                *
;* Freescale CodeWarrior for the HC12 Program directory       *
;**************************************************************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF Entry, _Startup, main, Port_u, Current, Count, Temp, Port_u_array, Read_array  
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK, Read_portU, Sequence, Next     ; symbol defined by the linker for the end of the stack




; variable/data section

Variables: Section 
Count:    	ds.b 	1
Current:  	ds.b 	1
Val:        ds.b  1
Temp:       ds.b  1



Constants: Section 
Port_u:  	equ $268 
Ddr_u:   	equ $26A 
Psr_u:  	equ $26D
Pder_u:  	equ $26C 
Port_s:   equ $248
Ddr_s:    equ $24A
Port_u_array:	  dc.b	$80, $40, $20, $10,$0
Read_array:   	dc.b  $14, $88, $84, $82, $48, $44, $42, $28, $24, $22, $18, $12, $81, $41, $21, $11,$0
;Port_u_array:	  dc.b	$70, $B0, $D0, $E0,$0
;Read_array:   	dc.b  $EB, $77, $7B, $7D, $B7, $BB, $BD, $D7, $DB, $DD, $E7, $ED, $7E, $BE, $DE, $EE,$0




MyCode: SECTION 
main: 
_Startup: 
Entry: 
            CLI
            LDS     #__SEG_END_SSTACK
            BSET	  Ddr_s,	#$FF	; activate all the Leds of Port_s
            BSET	  Ddr_u,	#$F0	; enabling all the bits 1-3 inputs and bits 4-7 outputs for port u
        		BSET	  Psr_u,	#$0F	; set bits 1-3 as pull up port u
        		BSET	  Pder_u,	#$0F	; activate pull up on pins 0-3
        	  clr     Val

;Check_LED:   LDAA 	  #$0			; Used to check if left or right LEDs should turn
;	        	STAA    Val
;	        	LDAA    #0
;	        	STAA    Count
           
Read:
            JSR	Sequence		; Reads the keypad
         
	        	                ; Increase A by 1 to indicate keypad was pressed
	          LDAA    Val
	          CMPA    #0			; checks if keypad was pressed twice
	          BNE     LED2		; branch to display keypad pressed value on the left LEDs
	          
LED1:       LDAB    Port_s		; Load the values of port_s into B
            ANDB    #$F0		  ; Clearing right side LEDs
            ORAB    Current		; Adding value of Keypad pressed to right side
            STAB    Port_s		; Sending B to Port_s
            LDAA    #1
            STAA    Val
            BRA     Read     	; Loop back to read keypad again
	          
	          
LED2:       LDAB    Port_s		; Load the values of port_s into B 
            ANDB    #$0F		  ; Clearing left side LEDs
            LSL     Current		; Shifting Current value to the 2nd Byte
            LSL     Current
            LSL     Current
            LSL     Current
            ORAB    Current		; Adding value of Keypad pressed to left side
		        STAB	  Port_s		; Sending B to Port_s
		        clr     Val
            BRA     Read	      ; Loop back to read keypad again and reset counter A to 0    
              

            NOP
