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

   
            XDEF Port_u, Entry, _Startup, main, ROW_SCAN, LU_PORT_U, PD_BUTTONS, KEY_PRESSED,COUNT,Port_t,T_ON,CRGFLG;PRESSED_OR_NOT_PRESSED, 

            XREF  __SEG_END_SSTACK, key,RTI_ISR  ; symbol defined by the linker for the end of the stack     

;Constants
MY_CONST: SECTION  
Port_t: EQU $240 ; SWITCH./ DC_MOTOR
Port_t_ddr: EQU $242 ;BIT3 DC MOTOR
Port_u:      EQU $268
Port_u_ddr:  EQU $26A
Port_u_psr:  EQU $26D
Port_u_pder: EQU $26C
ROW_SCAN:   DC.B  $80, $40, $20, $10, $00
PD_BUTTONS:  DC.B  $14, $88, $84, $82, $48, $44, $42, $28, $24, $22, $18, $12, $81, $41, $21, $11
IER: EQU $0038 ;INTERRUPT ENEBALE REGISTER
ICR: EQU $003B ;INTERRUPT CONTROL REGISTER


; variable/data section
MY_VAR: SECTION
; Insert here your data definition.
COUNT: DS.B 1
TEMP: DS.B 1
LU_PORT_U: DS.B  1
KEY_PRESSED: DS.B 1 
T_ON: DS.B 1 ;KEY_PREESED
T_OFF: DS.B 1;SET TO 15 DECIMAL OR $0F 





; code section
MyCode:     SECTION
main:
_Startup:
Entry:            


            LDS   #__SEG_END_SSTACK   ; initialize the stack pointer
            BSET  $24A, #$FF
            BSET  Port_u_ddr, #$F0
            BSET  Port_u_psr, #$0F
            BSET  Port_u_pder, #$0F
            BSET  Port_t_ddr, #$08  ;BSET  Port_t, #$08 ; switch 4 is up DC can now spin / possible set to brset later
                                    
            BSET  Port_t, #$08        ; switch 4 is up DC can now spin / possible set to brset later
                                      ;to stop BCLR PORT_T, #$00
 
           CLI                        ;clear I flag in ccr
           BSET IER,#$80              ;Sets bit 7 of interrupt enebel register
           BSET ICR,#$60              ;4,000 ms delay 

            
            
READ_KEYPAD:  

            JSR   key  
            LDAB KEY_PRESSED 
            STAB T_ON
            BRA READ_KEYPAD

           
        
           
           
            
            
            
            
            
            
            
            
            
            