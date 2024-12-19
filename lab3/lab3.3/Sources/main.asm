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





Variables: Section


Constants: Section
port_p equ $258
p_ddr: equ $25A
array: dc.b $0A,$12,$14,$0C,$0

Code:      Section
main:
_Startup:  
Entry:
      
          LDAB     #%00011110
          STAB     p_ddr
     
Array_loop:LDX      #array
loop:      LDAA     1,x+
          CMPA     #0
          BEQ      Array_loop
          STAA     port_p
   
          LDY     #30000
Delay:    DEY 
          BNE     Delay    
          
          BRA     loop
          
          nop
            