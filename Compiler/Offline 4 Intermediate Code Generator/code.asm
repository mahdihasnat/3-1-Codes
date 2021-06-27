.MODEL SMALL
.STACK 1000H
.DATA
FIXED_POINT_MULTIPLIER DW 64H
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
foo PROC
PUSH BP
MOV BP , SP
SUB SP , 2
;Line 7: integar = 1
MOV CX , 1
MOV -2[BP] , CX
;Line 7: CX = assigned value
MOV CX , -2[BP]
PUSH CX
CALL PRINTLN
MOV CX , -2[BP]
SUB SP , -2
JMP foo_exit
ADD SP , 2
foo_exit:
POP BP
RET 0
foo ENDP
main PROC
PUSH BP
MOV BP , SP
;Line 30: DATA SEGMENT INITIALIZATION
MOV AX, @DATA
MOV DS, AX
SUB SP , 2
;Line 16: integar = 2
MOV CX , 2
MOV -2[BP] , CX
;Line 16: CX = assigned value
;Line 17: integar = 0
MOV CX , 0
JCXZ after_and_0
CALL foo
after_and_0:
JCXZ if_false1
;>>
	MOV CX , -2[BP]
	PUSH CX
	CALL PRINTLN
	JMP if_end1
	;<<
if_false1:
;>>
	;<<
if_end1:
SUB SP , 2
;Line 23: integar = 4
MOV CX , 4
MOV -4[BP] , CX
;Line 23: CX = assigned value
;Line 24: integar = 1
MOV CX , 1
CMP CX , 0
JNZ after_or_2
CALL foo
after_or_2:
JCXZ if_false3
;>>
	MOV CX , -4[BP]
	PUSH CX
	CALL PRINTLN
	JMP if_end3
	;<<
if_false3:
;>>
	;<<
if_end3:
ADD SP , 4
main_exit:
POP BP
;Line 30: EXIT 0
MOV AH, 4CH
INT 21H
RET 0
main ENDP
END main
