.MODEL SMALL
.STACK 1000H
.DATA
FIXED_POINT_MULTIPLIER DW 64H
x DW 1 DUP (0000H)
mema DW 5 DUP (0000H)
.CODE
println PROC
    ;print word variable stored in stack

    ;    IF NUMBER < 0
    ;        PRINT - SIGN
	
	push bp 
	
	mov bp,sp
	
	mov bx , word ptr [bp + 4] ; bx = variable
	
    

    CMP bX , 0
    JGE println_positive_number ; IF variable >=0 THEN NO PRINTING

        
        MOV AH, 02H ; AG <- 02 , MODE TO PRINT CHARACTER FROM DL
        MOV DL, 002DH ; print -
        INT 21H
        
        NEG bx

	println_positive_number:


	mov ax,bx
	mov bx,10
	
    ;    DO
    ;        NUMBER /= 10
    ;        CNT ++
    ;        PUSH REMINDER
    ;    WHILE NUMBER!=0

    MOV CX , 0 ; CX = COUNTER

    MORE_TO_PRINT:
        ;CWD  ; CONVERT WORD AX TO DOUBLE WORD DX:AX
        MOV DX , 0 ; SINCE NUMBER IS POSITIVE NOW SO WE CAN SET DX = 0 , IT WILL HELP FOR CASE AX = -(2^15)
        
        DIV bx ;QUOTIENT IN AX , REMINDER IN DX

        PUSH DX ; PUSH  DX = REMINDER
        INC CX ; CNT++

        CMP AX , 0000H
        JNE MORE_TO_PRINT ;AX != 0

    ;   WHILE( CNT --)
    ;        PRINT( STACK.TOP())
    ;        STACK.POP()

    JCXZ println_exit ;IF CX IS ZERO THEN NOTING TO PRINT , THIS CASE WONT ARISE THOUGH

    println_print_digits:


            MOV AH, 02H ; AG <- 02 , MODE TO PRINT CHARACTER FROM DL
            POP DX
            ADD DL, '0'
            INT 21H


        LOOP println_print_digits

    println_exit:

    MOV AH, 02H ; AG <- 02 , MODE TO PRINT CHARACTER FROM DL
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    
    POP BP

    RET 2
    
println ENDP
main PROC
PUSH BP
MOV BP , SP
;Line 13: DATA SEGMENT INITIALIZATION
MOV AX, @DATA
MOV DS, AX
SUB SP , 2
SUB SP , 60
;Line 9: integar = 3
MOV DX , 3
MOV -2[BP] , DX
MOV DX , -2[BP]
PUSH DX
CALL PRINTLN
;Line 10: integar = 3
MOV DX , 3
PUSH DX
;Line 10: integar = 4
MOV DX , 4
POP AX
XCHG AX ,DX
;Line 10: put element to stack array
PUSH BP
SAL DX , 1
ADD DX , -62
ADD BP , DX
MOV PTR WORD [BP] , AX
MOV DX , AX
POP BP
;Line 10: integar = 3
MOV DX , 3
;Line 10: get array element from stack
PUSH BP
SAL DX , 1
ADD DX , -62
ADD BP , DX
MOV DX , PTR WORD [BP]
POP BP
MOV -2[BP] , DX
MOV DX , -2[BP]
PUSH DX
CALL PRINTLN
;Line 11: integar = 3
MOV DX , 3
PUSH DX
;Line 11: integar = 5
MOV DX , 5
POP AX
XCHG AX ,DX
;Line 11: set  element to memory array
SAL DX , 1
MOV BX , DX
MOV PTR WORD mema[BX] , AX
MOV DX , AX
;Line 11: integar = 3
MOV DX , 3
;Line 11: get array element from memory
SAL DX , 1
MOV BX , DX
MOV DX , PTR WORD mema[BX]
MOV -2[BP] , DX
MOV DX , -2[BP]
PUSH DX
CALL PRINTLN
;Line 12: integar = 6
MOV DX , 6
MOV x , DX
MOV DX , x
PUSH DX
CALL PRINTLN
ADD SP , 62
main_exit:
POP BP
;Line 13: EXIT 0
MOV AH, 4CH
INT 21H
RET 0
main ENDP
END main
