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
            XDEF Entry, _Startup, main
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK      ; symbol defined by the linker for the end of the stack




Variables:		Section


Constants:		Section
Port_s		EQU		$248		; Port s address
Ddr_s			EQU		$24A		; Port s ddr address
Array:		dc.b	$81,$42,$18,$24,$42,$0		; defining Sequence

Code:			Section
main:
_Startup:
Entry:
			        LDAB		#$FF 		    ; Load B with all bits of Port_s_ddr
              STAB		Ddr_s		    ; Store value of B to ddr_s for LEDs

Array_loop:		LDX		  #Array	    ; Load address of Array into X
Loop:			    LDAA		1, X+		    ; Load value from X+1 into A and X=X+1
              CMPA		#0		      ; Compare value of A with 0	
              BEQ 		Array_loop	; Branch to Array_loop if A = 0
              STAA		Port_s	    ; Output value to Port_s

	
              LDY		  #30000	    ; Load delay counter of 30 milliseconds
Delay:		    DEY			      	    ; decrement Y
              BNE	  	Delay		    ; Branch to Delay if Y != 0
              BRA		  Loop		    ; Branch to loop
			        
			        Nop

