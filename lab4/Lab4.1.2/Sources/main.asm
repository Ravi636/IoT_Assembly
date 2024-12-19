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
Array1:		dc.b	$81,$42,$18,$24,$42,$0				; defining Sequence 1
Array2:		dc.b	$80,$40,$20,$10,$08,$04,$02,$01,$0		; defining Sequence 2
Val_T:		ds.b	2

Constants:		Section
Port_s		EQU		$248		; Port s address
Ddr_s			EQU		$24A		; Port s ddr address
Port_t		EQU		$240		; Port t address


; code section
MyCode:     SECTION
main:
_Startup:
Entry:
            LDAB	  	#$FF 		; Load B with all bits of Port_s_ddr
            STAB	  	Ddr_s		; Store value of B to ddr_s for LEDs
            LDAA	  	Port_t	; Load A with value of Port_t
           
            	
            CMPA	 	#0		  ; Compare value of A with 0
            BEQ		  A1_loop	; Branch to A1_loop if A = 0
            BRA		  A2_loop	; Branch to A1_loop

A1_loop:	  LDX		  #Array1	; Load address of Array1 into X
Loop1:	    LDAA	  1, X+		; Load value from X+1 into A and X=X+1
            CMPA		#0	  	; Compare value of A with 0	
            BEQ 		Entry		; Branch to Entry if A = 0
            STAA		Port_s	; Output value to Port_s
           	BRA		  Start_delay


A2_loop:  	LDX		  #Array2	; Load address of Array1 into X
Loop2:    	LDAA		1, X+		; Load value from X+1 into A and X=X+1
            CMPA		#0	  	; Compare value of A with 0	
            BEQ 		Entry		; Branch to Entry if A = 0
            STAA		Port_s	; Output value to Port_s


            	
Start_delay:LDY		  #500000	; Load delay counter of 30 milliseconds
Delay:    	DEY				        ; decrement Y
            BNE		  Delay		; Branch to Delay if Y != 0
            LDAB		Port_t		; Load value of Val_T into B
            CMPB	  #0	  	; Compare Value of B with 0
            BEQ	    Loop1		; Branch to Loop1 if B = 0
            BRA		  Loop2		; Branch to Loop2
            END
            Nop
