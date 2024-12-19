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
            XDEF PORT_U, Entry, _Startup, main, Row_scan, LU_PORT_U, PD_BUTTONS, Key_pressed
            XREF __SEG_END_SSTACK, Read_PortU      ; symbol defined by the linker for the end of the stack




; variable/data section
MY_VAR: SECTION
; Insert here your data definition.

LU_PORT_U:  DS.B  1
Key_pressed:DS.B 1 
T_on:       DS.B 1 ;KEY_PREESED
T_off:      DS.B 1;SET TO 15 DECIMAL OR $0F 


;Constants
MY_CONST: SECTION  
PORT_T:       EQU $240 ; SWITCH./ DC_MOTOR
PORT_T_DDR:   EQU $242 ;BIT3 DC MOTOR
PORT_U:       EQU $268
PORT_U_DDR:   EQU $26A
PORT_U_PSR:   EQU $26D
PORT_U_PDER:  EQU $26C
Row_scan:     DC.B  $80, $40, $20, $10, $00
PD_BUTTONS:   DC.B  $14, $88, $84, $82, $48, $44, $42, $28, $24, $22, $18, $12, $81, $41, $21, $11


; code section
MyCode:     SECTION
main:
_Startup:
Entry:            
            LDS  #__SEG_END_SSTACK     ; initialize the stack pointer
            
            BSET  $24A, #$FF
            BSET  PORT_U_DDR, #$F0
            BSET  PORT_U_PSR, #$0F
            BSET  PORT_U_PDER, #$0F
            BSET  PORT_T_DDR, #$08
            BSET  PORT_T, #$08          ; switch 4 is up DC can now spin
            
             

            
            
Read_Keypad:  
            JSR   Read_PortU  
 
KEY_IS_PRESSED:
            LDAB  Key_pressed
            STAB  T_on
            LDAA  #$0F
            SBA
            STAA  T_off
            BRA   T_ON_CHECK
            
T_ON_CHECK:
            LDAA  T_on
            CMPA  #$01
            BMI   T_OFF_CHECK 
            BRA   T_ON_NOT_ZERO
            
T_ON_NOT_ZERO:
            BSET   PORT_T,#$08
            LDY    #4000 ;4ms delay for PWM strat
                 
PWM_DELAY1:
            DEY 
            BNE    PWM_DELAY1
            DEC    T_on
            BRA    T_ON_CHECK   
                           
T_OFF_CHECK: 
            LDAB   T_off
            CMPB   #01
            BMI    Read_Keypad
            BRA    T_OFF_NOT_ZERO
           
T_OFF_NOT_ZERO:
            BCLR    PORT_T,#$08
            LDY     #4000 ;4ms delay for PWM strat
           
PWM_DELAY2:
            DEY 
            BNE     PWM_DELAY2
            DEC     T_off
            BRA     T_OFF_CHECK       