  XDEF  Read_PortU
  XREF  PORT_U, Row_scan, Key_pressed ,LU_PORT_U, PD_BUTTONS



Read_PortU:      PSHB
                PSHA
LOAD_FIRST_ROW: LDX   #Row_scan      ; load x with first row array value
LOAD_NEXT_ROW:  LDAB  1,X+          ; load row into b, and set x to next row
                
                BEQ   PWM ; if checked last row, go back to first
                STAB  PORT_U        ; send the row array value to port u
                JSR   Start_Delay   ; delay for 1ms
                BRCLR PORT_U, #$0F, LOAD_NEXT_ROW ; if no button pressed then load the next row. will continue on if a button has been pressed
                LDAA  PORT_U        ; load port u into a
                STAA  LU_PORT_U     ; save port u value for later. use with lu table
              


RELEASED:       LDX   #PD_BUTTONS    ; address of first pull down button
                LDAA  #00            ; initialize counter
LU_TABLE_LOOP:  LDAB  1,X+           ; load address of pull down button into x and go to next button
                CMPB  LU_PORT_U      ; if match is found
                BEQ   MATCH_FOUND
                INCA 
                bra LU_TABLE_LOOP 
        
        
        PWM:    PULA 
                PULB
                RTS               
               
                

MATCH_FOUND:    STAA  Key_pressed    ; store the counter to key_pressed
                PULA
                PULB
                RTS                  ; go back to main loop              
                
                          
Start_Delay:	LDY 	3000 	    ; Load delay counter of 30 milliseconds
Delay: 		    DEY 			        ; decrement Y
			        BNE   Delay 		  ; Branch to Delay if Y != 0
              RTS

