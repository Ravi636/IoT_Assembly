  XDEF  SendMessageInfo
  XREF  SendsChr
  
  
SendMessageInfo:
                
                
        
        LEAX  3, SP     ; Array
        LDY   5, SP     ; Counter
        
Loop:
        LDAA  1, X+
        PSHA
        CALL  SendsChr
        PULA  
        LEAS  -1, SP
        DEY
        CPY   #0
        BNE   Loop
        RTC