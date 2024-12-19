
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

Val:      ds.b  1		

Constants:		Section
Count     dc.b  0
Lookup:		dc.b	$eb,$77,$7b,$7d,$b7,$bb,$bd,$d7,$db,$dd,$e7,$ed,$7e,$be,$de,$ee, $0

; code section
MyCode:     SECTION
main:
_Startup:
Entry:

    			  LDX		  #Lookup	; Load address of Lookup Table into X
			      
			      LDAB     Count   ; Load B with Count value
			      
            				        	
Loop:       LDAA    1, X+   ; Load value from X+1 into A and X=X+1
            CMPA		Val   	; Get Lookup Value
            BEQ     Match            
            CMPA    #0
            BEQ     No_Match
            INCB             ; Increment Y
            BRA		  Loop		; Branch to loop
			      
Match:      TFR     B,A   
            BRA     Done
            
            
No_Match:   LDAA    $FF

Done:       
			      Nop

