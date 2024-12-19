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
VAL:      ds.b 1 ; defining Val variable space
RESULT:   ds.b 1 ; defining result variable space

Constants: Section
Slope     dc.b $44  ; Slope value = 68
Offse   dc.b $C   ; Offset value (b) = 12


Code: Section
main:
_Startup:  
Entry:
      
      LDAA    VAL     ;to be scaled
      LDAB    #68   ;B = 68
      MUL             ;D = A X B
      
      LDX     #$64    ;X = 100
      IDIV            ;D/X = X...D, quotient in X
      
      LDAB    Offse  ; B = offset = 12 
      ABX             ; Adding X = X+B
      
      TFR     X,A     ;Move remainder to BA
      
      TFR     D,B     ;moving D to A
      
      STAA    RESULT  ;Store X into RESULT
      
   
      nop
            