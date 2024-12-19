
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
Lookup:		dc.b	$12,$3A,$61,$86,$18,$43,$6F,$C3,$24,$4B,$7A,$D6,$36,$51,$92,$F1		

Constants:		Section
Port_s		EQU		$248		; Port s address
Ddr_s			EQU		$24A		; Port s ddr address
Port_t		EQU		$240		; Port t address


; code section
MyCode:     SECTION
main:
_Startup:
Entry:
            LDAB		#$FF 		; Load B with all bits of Port_s_ddr
            STAB		Ddr_s		; Store value of B to ddr_s for LEDs

Loop:			  LDX		  #Lookup	; Load address of Lookup Table into X
			      LDAB		Port_t	; Load B with Value of Port_t
            ABX				      ; Add A to X to find address of 	
            LDAA		0, X		; Get Lookup Value
            STAA		Port_s	; Send value of A to Port_s
            BRA		  Loop		; Branch to loop
			      END
			      Nop

