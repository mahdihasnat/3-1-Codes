.MODEL SMALL
.STACK 1000H
.DATA
FIXED_POINT_MULTIPLIER DW 64H
x DW 1 DUP (0000H)
dp DW 100 DUP (0000H)
mema DW 100 DUP (0000H)
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
fun PROC
PUSH BP
MOV BP , SP
fun_exit:
POP BP
RET 0
fun ENDP
foo PROC
PUSH BP
MOV BP , SP
foo_exit:
POP BP
RET 4
foo ENDP
bar PROC
PUSH BP
MOV BP , SP
bar_exit:
POP BP
RET 0
bar ENDP
main PROC
PUSH BP
MOV BP , SP
;Line 26: DATA SEGMENT INITIALIZATION
MOV AX, @DATA
MOV DS, AX
CALL fun
;Line 20: integar = 10
MOV DX , 10
MOV x , DX
;Line 21: integar = 5
MOV DX , 5
PUSH DX
;Line 21: integar = 34
MOV DX , 34
POP AX
XCHG AX ,DX
;Line 21: set  element to memory array
SAL DX , 1
MOV BX , DX
MOV PTR WORD mema[BX] , AX
MOV DX , AX
;Line 22: integar = 5
MOV DX , 5
;Line 22: get array element from memory
SAL DX , 1
MOV BX , DX
MOV DX , PTR WORD mema[BX]
PUSH DX
MOV DX , x
PUSH DX
CALL foo
;Line 23: integar = 10
MOV DX , 10
PUSH DX
;Line 23: integar = 199
MOV DX , 199
POP AX
XCHG AX ,DX
;Line 23: set  element to memory array
SAL DX , 1
MOV BX , DX
MOV PTR WORD dp[BX] , AX
MOV DX , AX
CALL bar
MOV x , DX
MOV DX , x
PUSH DX
CALL PRINTLN
main_exit:
POP BP
;Line 26: EXIT 0
MOV AH, 4CH
INT 21H
RET 0
main ENDP
END main
