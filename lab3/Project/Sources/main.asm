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
VAL:      ds.b 10 ; defining Val variable space
RESULT:   ds.w 1 ; defining result variable space

Constants: Section
num_1     dc.b $F6  ; 
num_2     dc.b $EC   ;


Code:      Section
main:
_Startup:  
Entry:
      
     ldaa   num_1
     adda   num_2
      
   
      nop
            