#ifndef _MAIN_ASM_H
#define _MAIN_ASM_H
 
void SendMessageInfo(char*, int, int);
#ifdef __cplusplus
    extern "C" { /* our assembly functions have C calling convention */
#endif
void asm_main(void);	//prototype for assembly function	

#ifdef __cplusplus
    }
#endif

#endif /* _MAIN_ASM_H */
