  XDEF  key
  XREF  Port_u, ROW_SCAN, KEY_PRESSED , PRESSED_OR_NOT_PRESSED ,LU_PORT_U, PD_BUTTONS



key:         PSHB
                PSHA
LOAD_FIRST_ROW: LDX   #ROW_SCAN       ; load x with first row array value
LOAD_NEXT_ROW:  LDAB  1,X+            ; load row into b, and set x to next row
                
                BEQ   Not_pressed             ; if checked last row, go back to first
                STAB  Port_u          ; send the row array value to port u
                JSR   DELAY_ENTRY     ; delay for 1ms
                BRCLR Port_u, #$0F, LOAD_NEXT_ROW ; if no button pressed then load the next row. will continue on if a button has been pressed
                LDAA  Port_u          ; load port u into a
                STAA  LU_PORT_U       ; save port u value for later. use with lu table
              


RELEASED:       LDX   #PD_BUTTONS    ; address of first pull down button
                LDAA  #00            ; initialize counter
LU_TABLE_LOOP:  LDAB  1,X+           ; load address of pull down button into x and go to next button
                CMPB  LU_PORT_U      ; if match is found
                BEQ   MATCH_FOUND
                INCA 
                BRA LU_TABLE_LOOP 
        
        
Not_pressed:    PULA 
                PULB
                RTS               
               

MATCH_FOUND:    STAA  KEY_PRESSED    ; store the counter to key_pressed
                PULA
                PULB
                RTS                  ; go back to main loop              
                
                          
DELAY_ENTRY:  LDY #3000
DELAY_LOOP    DEY 
              BNE DELAY_LOOP
              RTS
