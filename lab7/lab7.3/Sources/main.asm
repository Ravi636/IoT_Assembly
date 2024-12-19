
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

   
            XDEF PORT_U, Entry, _Startup, main, ROW_SCAN, LU_PORT_U, PD_BUTTONS, KEY_PRESSED,COUNT,PORT_T,T_ON,
            XDEF CRGFLG,PORT_P_DDR, PORT_T_DDR,PORT_S,STATE_FLAG,STEEPER_COUNT,RTI_COUNT,LED_COUNT_STATE_A,LED_COUNT_STATE_B
            XREF  __SEG_END_SSTACK, KEYPAD,RTI_ISR, CHECK_STATE ; symbol defined by the linker for the end of the stack    



; variable/data section
MY_VAR: SECTION
; Insert here your data definition.
COUNT: DS.B 1
TEMP: DS.B 1
LU_PORT_U: DS.B  1

KEY_PRESSED: DS.B 1
T_ON: DS.B 1 ;KEY_PREESED
T_OFF: DS.B 1;SET TO 15 DECIMAL OR $0F

STATE_FLAG: DS.B 1
STEEPER_COUNT: DS.B 1
LED_COUNT_STATE_A: DS.B 1
LED_COUNT_STATE_B: DS.B 1

RTI_COUNT: DS.B 1;CHECKS HOW MANY TIMES WE ENTER THE RTI




;Constants
MY_CONST: SECTION  
PORT_T: EQU $240 ; SWITCH./ DC_MOTOR
PORT_T_DDR: EQU $242 ;BIT3 DC MOTOR
PORT_U:      EQU $268
PORT_U_DDR:  EQU $26A
PORT_U_PSR:  EQU $26D
PORT_U_PDER: EQU $26C
ROW_SCAN:   DC.B  $80, $40, $20, $10, $00
PD_BUTTONS:  DC.B  $14, $88, $84, $82, $48, $44, $42, $28, $24, $22, $18, $12, $81, $41, $21, $11
IER: EQU $0038 ;INTERRUPT ENEBALE REGISTER
ICR: EQU $003B ;INTERRUPT CONTROL REGISTER
PORT_P: equ $258
PORT_P_DDR equ $25A
ARRAY DC.B $0A,$12,$14,$0C
PORT_S: EQU $248
PORT_S_DDR: EQU $24A


; code section
MyCode:     SECTION
main:
_Startup:
Entry:            

            LDS   #__SEG_END_SSTACK     ; initialize the stack pointer
            BSET  PORT_U_DDR, #$F0
            BSET  PORT_U_PSR, #$0F
            BSET  PORT_U_PDER, #$0F
            BSET  PORT_T_DDR, #$08
            ;BSET  PORT_T, #$08 ; switch 4 is up DC can now spin / possible set to brset later
            ;to stop BCLR PORT_T, #$00
            BSET PORT_S_DDR,#$FF
            
            CLI;clear I flag in ccr
            BSET IER,#$80;Sets bit 7 of interrupt enebel register
            BSET ICR,#$20 ;4,000 ms delay
            BSET PORT_P_DDR, #$1E


MAIN_CHECK_STATE:    
             BRSET   STATE_FLAG, #$01,STATE_A_TRANSITION         ; branch to Clockwise if bit 1 is 1
             BRA STATE_B_TRANSITION  
           
               

STATE_A_TRANSITION:
           
            BRA STATE_A

STATE_B_TRANSITION:
             BRA STATE_B          

STATE_A: ;0
KEY_LOOP:
            JSR  KEYPAD  
            LDAB KEY_PRESSED
            STAB T_ON
            LDAA STATE_FLAG
            CMPA #1
            BMI STATE_A
            BRA STATE_B

   
           
STATE_B:  ;1
            BCLR PORT_T,#$08;DC Motor not spining  
            LDAA #$1e
            STAA PORT_P_DDR
START:
            LDX #ARRAY
            LDAB STEEPER_COUNT
            ABX
            LDAA 0,X
            STAA  PORT_P  
            BRA MAIN_CHECK_STATE