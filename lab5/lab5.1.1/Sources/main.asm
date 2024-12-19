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
VAR_1:  dc.b $EC 
Constants: Section 
Port_s  equ $248 
Ddr_s   equ $24A 
Port_t  equ $240 

MyCode: SECTION 
main: 
_Startup: 
Entry: 
            LDAA    #$FF 
            STAA    Ddr_s     ; enabling all the leds for port s

            LDAA    VAR_1     ; load VAR_1 into A
            ANDA    #%10111111; clearing 6th bit of A             
            ORAA    #%00010000; set 4th bit of A
            STAA    VAR_1     ; storing it back into VAR_1
            
Loop_0bit:  LDAB    Port_t    ; load value of Port t into B
            ANDB    #%0000001 ; And B with %00000000                
            BEQ     Loop_0bit ; if equal 0 then branch back, so waits for bit bit to go high

Loop_0_low: LDAB    Port_t    ; load value of Port t into B
            BITB    #%0000001 ; check if bit 0 goes low   
            BNE     Loop_0_low; if not equal 0 then branch 
            STAA    Port_s    ;
            

            
            
            NOP
            
            
            
            
            
            
            
            
            
            
            
            
            
            
                             
            
start:      BRCLR Port_t,#$02,start 
            
            BRA Loop_low 
            
Loop_low:
           BRSET Port_t,#$02,Loop_low ;keep looping until bit 1 goes to low 
Loop_high: 
           BRCLR Port_t,#$02,Loop_high ;keep looping until bit 1 goes to high 
           BRA low_high   ;go to load values after going low and then high 

low_high: 
           STAA Port_s    ; load value of A into Port_s
           
           NOP 