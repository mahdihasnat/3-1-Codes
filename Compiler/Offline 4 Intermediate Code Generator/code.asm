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
;Line 19: DATA SEGMENT INITIALIZATION
MOV AX, @DATA
MOV DS, AX
SUB SP , 2
;Line 15: start of for loop
;Line 10: integar = 0
MOV DX , 0
MOV x , DX
for_body_6:
;>>
	;Line 10: Relational operator checking
	MOV DX , x
	PUSH DX
	;Line 10: integar = 20
	MOV DX , 20
	POP AX
	CMP AX , DX
	JL relop_is_ok_0
	MOV DX , 0
	JMP relop_end_1
	relop_is_ok_0:
	MOV DX , 1
	relop_end_1:
	CMP DX , 0
	JZ for_end_7
	;>>
		;Line 15: start of for loop statement
		;Line 14: start of for loop
		;Line 13: integar = 0
		MOV DX , 0
		MOV -2[BP] , DX
		for_body_4:
		;>>
			;Line 13: Relational operator checking
			MOV DX , -2[BP]
			PUSH DX
			MOV DX , x
			POP AX
			CMP AX , DX
			JL relop_is_ok_2
			MOV DX , 0
			JMP relop_end_3
			relop_is_ok_2:
			MOV DX , 1
			relop_end_3:
			CMP DX , 0
			JZ for_end_5
			;>>
				;Line 14: start of for loop statement
				MOV DX , x
				PUSH DX
				CALL PRINTLN
				;<<
			;Line 14: start of for loop step
			MOV DX , -2[BP]
			PUSH DX
			;Line 13: integar = 1
			MOV DX , 1
			POP AX
			ADD AX , DX
			MOV DX , AX
			MOV -2[BP] , DX
			JMP for_body_4
			;<<
		for_end_5:
		;<<
	;Line 15: start of for loop step
	MOV DX , x
	PUSH DX
	;Line 10: integar = 1
	MOV DX , 1
	POP AX
	ADD AX , DX
	MOV DX , AX
	MOV x , DX
	JMP for_body_6
	;<<
for_end_7:
;Line 16: integar = 12
MOV DX , 12
PUSH DX
;Line 16: integar = 12
MOV DX , 12
POP AX
IMUL DX
MOV DX , AX
MOV x , DX
MOV DX , x
PUSH DX
CALL PRINTLN
ADD SP , 2
main_exit:
POP BP
;Line 19: EXIT 0
MOV AH, 4CH
INT 21H
RET 0
main ENDP
END main
