;**************************************************************
;* This stationery serves as the framework for a              *
;* user application. For a more comprehensive program that    *
;* demonstrates the more advanced functionality of this       *
;* processor, please see the demonstration applications       *
;* located in the examples subdirectory of the                *
;* Freescale CodeWarrior for the HC12 Program directory       *
;**************************************************************

;  
;Objective:
;	Learn different addressing modes and assembler directives in a given program.



; Include derivative-specific definitions
            INCLUDE 'derivative.inc'
            

; export symbols
            XDEF Entry
            ;, _Startup, main
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK      ; symbol defined by the linker for the end of the stack

My_MACRO: SECTION
output: macro
        
        ldaa \1 
    
        staa \2
 
        endm

addoutput:  macro

            ldaa \1
            
            staa  \2

            endm

MY_ENTENDED_RAM:  SECTION
ADDEND: ds.b  1

MY_Constant:  section
cons1: equ  2



My_CONSTANT_ROM: 	section 
port_s: equ $248
port_t: equ $240
t_ddr:  equ $242
s_ddr:  equ $24a

; code section
My_Code:     SECTION
;main:
;_Startup:
Entry:
	    	ldab #$ff    ; load all 8 leds to b
	    	stab s_ddr  ;  store value of b to s_ddr for output  
	    	
	    	output  port_t, port_s
	    
	    	addoutput cons1, port_s
	    	 
	    	nop
	      end
	      
