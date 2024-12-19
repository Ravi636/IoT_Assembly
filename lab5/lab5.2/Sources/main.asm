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
            XDEF Entry, _Startup, main, DelayCount
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK, Start      ; symbol defined by the linker for the end of the stack





Variables: Section
DelayCount:   ds.b    1

Constants: Section
Port_t  equ $240
port_p  equ $258
p_ddr:  equ $25A
array:  dc.b $0A,$12,$14,$0C,$0
array2: dc.b $0C,$14,$12,$0A,$0


Code:      Section
main:
_Startup:  
Entry:
          lds      #__SEG_END_SSTACK
          LDAB     #%00011110
          STAB     p_ddr
       
Check1:   BRCLR   Port_t, #$01, Check_2           ; branch to check_2 if bit 0 is 0
                    

          BRCLR   Port_t, #$02, Counter_clockwise ; branch to counter_clockwise if bit 1 is 0
          BRA     Check1                          ; branch to check1 because both bits are 11                    
          
Check_2:  BRSET   Port_t, #$02, Clockwise         ; branch to clockwise if bit 1 is 1
          BRA     Check1                          ; branch to check1 because both bits are 00

Clockwise:          
Array_loop:LDX      #array
loop:     LDAA     1,x+
          CMPA     #0
          BEQ      Array_loop
          STAA     port_p
          BRA      Check3
          
Counter_clockwise:
Array_loop2:LDX      #array2
loop2:     LDAA     1,x+
          CMPA     #0
          BEQ      Array_loop2
          STAA     port_p          

Check3:   BRSET   Port_t, #$04, speed_high         ; branch to clockwise if bit 2 is 1   
          
          BRA     speed_low
          
speed_high:LDY   #15000
          STY    DelayCount
          BRA    speed
          
speed_low:LDY   #60000
          STY    DelayCount          
          
speed:    JSR       Start    

Check1a:   BRCLR   Port_t, #$01, Check_2a           ; branch to check_2 if bit 0 is 0
                    

          BRCLR   Port_t, #$02, loop2 ; branch to counter_clockwise if bit 1 is 0
          BRA     Check1a                          ; branch to check1 because both bits are 11                    
          
Check_2a:  BRSET   Port_t, #$02, loop         ; branch to clockwise if bit 1 is 1
          BRA     Check1a                          ; branch to check1 because both bits are 00
            
          ;BRCLR   Port_t, #$01, loop
          ;BRA       loop2
          
          
          nop
            
