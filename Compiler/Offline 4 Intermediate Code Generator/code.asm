.MODEL SMALL
.STACK 1000H
.DATA
FIXED_POINT_MULTIPLIER DW 64H
x DW 1 DUP (0000H)
mema DW 10 DUP (0000H)
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
;Line 25: DATA SEGMENT INITIALIZATION
MOV AX, @DATA
MOV DS, AX
SUB SP , 2
;Line 8: integar = 0
MOV DX , 0
MOV -2[BP] , DX
;Line 22: start of for loop
for_body_0:
;>>
	;Line 10: integar = 1
	MOV DX , 1
	CMP DX , 0
	JZ for_end_1
	;>>
		;Line 22: start of for loop statement
		SUB SP , 2
		MOV DX , -2[BP]
		MOV AX , DX
		DEC AX 
		MOV -2[BP] , AX
		MOV -4[BP] , DX
		MOV DX , -4[BP]
		PUSH DX
		CALL PRINTLN
		MOV DX , x
		MOV AX , DX
		DEC AX 
		MOV x , AX
		MOV DX , x
		PUSH DX
		CALL PRINTLN
		SUB SP , 2
		;Line 19: integar = 5
		MOV DX , 5
		;Line 19: set  element to memory array
		SAL DX , 1
		MOV BX , DX
		MOV DX , PTR WORD mema[BX]
		MOV AX , DX
		DEC AX 
		MOV PTR WORD mema[BX] , AX
		;Line 20: integar = 5
		MOV DX , 5
		;Line 20: get array element from memory
		SAL DX , 1
		MOV BX , DX
		MOV DX , PTR WORD mema[BX]
		MOV -6[BP] , DX
		MOV DX , -6[BP]
		PUSH DX
		CALL PRINTLN
		ADD SP , 4
		;<<
	;Line 22: start of for loop step
	JMP for_body_0
	;<<
for_end_1:
MOV DX , x
PUSH DX
CALL PRINTLN
ADD SP , 2
main_exit:
POP BP
;Line 25: EXIT 0
MOV AH, 4CH
INT 21H
RET 0
main ENDP
END main
