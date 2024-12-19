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




; variable/data section
Variables: Section 
 


Constants: Section 
Port_s  equ $248 
Ddr_s   equ $24A 
Port_t  equ $240 
Mask    equ $FF
Mask1    equ $01


MyCode: SECTION 
main: 
_Startup: 
Entry: 

start:
            BSET    Ddr_s, Mask  ; set all the leds for port s
loop_0high:  BRCLR   Port_t, Mask1, loop_0high ;branch if switch 1 is low

loop_0low:  BRSET   Port_t, Mask1, loop_0low  ;branch if switch 1 is high
loop_0high2:  BRCLR   Port_t, Mask1, loop_0high2 ;branch if switch 1 is low
            BSET    Port_s, #%01000000
            
            
           
            
            
            NOP
            
            
