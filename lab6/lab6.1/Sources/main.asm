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



; code section
MyCode:     SECTION
main:
_Startup:
Entry:

            LDS     #__SEG_END_SSTACK ; initialize the stack pointer
            LDAA    #$11;
            LDAB    #$22
            LDX     #$3333
            LDY     #$4444
            JSR     StackRoutine
            
StackRoutine:
            
            PSHA
            PSHB
            PSHX
            PSHY
            LDAA    #$0
            LDAB    #$0
            LDX     #$0
            LDY     #$0
            PULA
            PULB
            PULX
            PULY
            NOP             ; result in D
