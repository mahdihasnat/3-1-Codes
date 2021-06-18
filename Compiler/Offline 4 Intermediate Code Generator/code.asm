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
SUB SP , 2
SUB SP , 2
SUB SP , 20
;Line 11: integar = 1
MOV DX , 1
CMP DX , 0
JZ if_false0
;>>
	;Line 12: integar = 2
	MOV DX , 2
	SUB SP , -26
	JMP foo_exit
	JMP if_end0
	;<<
if_false0:
;>>
	;<<
if_end0:
ADD SP , 24
ADD SP , 2
foo_exit:
POP BP
RET 0
foo ENDP
main PROC
PUSH BP
MOV BP , SP
;Line 20: DATA SEGMENT INITIALIZATION
MOV AX, @DATA
MOV DS, AX
CALL foo
main_exit:
POP BP
;Line 20: EXIT 0
MOV AH, 4CH
INT 21H
RET 0
main ENDP
END main
