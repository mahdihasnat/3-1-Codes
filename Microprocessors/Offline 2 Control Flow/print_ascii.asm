.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH


.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH , 02H
    MOV CX , 255
    MOV DL , 0
    
    PRINT_LOOP:
        INT 21H
        inc DL
        dec CX
        JNZ print_loop
         
    
    
    ;Return 0
    MOV AH, 4CH
    INT 21H
    
        
MAIN ENDP
    END MAIN