  XDEF Sequence
  XREF Port_u, Start_Dealy, Count, Current, Temp, Port_u_array, Read_array


Sequence:	
              
              LDX	  #Port_u_array	  	; load address of array into X
              
Next:         LDAA  1,X+				; Load value of X into A
               				; If end of the array is reached then reload the array back into X	
              BEQ   Sequence  
              STAA	Port_u		    ; Load value of array into Port_u
              				          ; Increment the register X
              JSR	  Start_Dealy		; Start delay of 1 millisecond
              
Read_portU:		LDAA	Port_u        ; Read value of Port_u into A
              STAA  Current			  ; Save the value of Port_u for later use
              STAA  Temp
              BRCLR Temp, #$0F, Next ;Not pressed then load next row
              ;ANDA	#$0F		     	; Ignore the 3 and 4 bytes
              ;CMPA  #$0F				  ; Test if A = $0F / no key is pressed
              ;BEQ 	Next          ; Zero then branch to next sequence
              ;BRA   Key_pressed		; Branch to Key_pressed
             	
Key_pressed:  
              LDAA  Port_u			   ; Read value of Port_u into A
              STAA  Temp
              BRCLR Temp, #$0F, Not_pressed ; Key not pressed and branch
              ;ANDA  #$0F			    ; Ignore the 3 and 4 bytes
              ;CMPA  #$0F			    ; Test if A = $0F / no key is pressed
              ;BEQ   Not_pressed		; Zero then branch to key Not_pressed
              BRA   Key_pressed		; Branch to back to Key_pressed 

Not_pressed:  LDY		  #Read_array	; Load address of Lookup Table into Y			      
			        LDAA     #0   ; Load A with Count value
			      
            				        	
Loop:         LDAB    1, Y+   ; Load value from X+1 into B and X=X+1
              CMPB    #00	    ; Check if Look up value is at the end of the array
              BEQ     Not_pressed     ; 
              CMPB		Current ; Get Lookup Value
              BEQ     Match            
              INCA            ; Increment A
              BRA		  Loop		; Branch to loop
  			      
Match:           
              STAA    Current
              
              
              RTS

