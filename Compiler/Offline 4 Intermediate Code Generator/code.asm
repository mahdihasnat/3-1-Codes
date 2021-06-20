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
;>>
	PUSH BP
	MOV BP , SP
	;Line 5: Relational operator checking
	MOV DX , 4[BP]
	PUSH DX
	;Line 5: integar = 0
	MOV DX , 0
	POP AX
	CMP AX , DX
	JE relop_is_ok_0
	MOV DX , 0
	JMP relop_end_1
	relop_is_ok_0:
	MOV DX , 1
	relop_end_1:
	CMP DX , 0
	JNZ after_or_4
	;Line 5: Relational operator checking
	MOV DX , 6[BP]
	PUSH DX
	;Line 5: integar = 0
	MOV DX , 0
	POP AX
	CMP AX , DX
	JE relop_is_ok_2
	MOV DX , 0
	JMP relop_end_3
	relop_is_ok_2:
	MOV DX , 1
	relop_end_3:
	after_or_4:
	CMP DX , 0
	JZ if_false5
	;>>
		;Line 6: integar = 1
		MOV DX , 1
		SUB SP , 0
		JMP foo_exit
		JMP if_end5
		;<<
	if_false5:
	;>>
		MOV DX , 6[BP]
		PUSH DX
		MOV DX , 4[BP]
		PUSH DX
		;Line 7: integar = 1
		MOV DX , 1
		POP AX
		SUB AX , DX
		MOV DX , AX
		PUSH DX
		CALL foo
		PUSH DX
		MOV DX , 6[BP]
		PUSH DX
		;Line 7: integar = 1
		MOV DX , 1
		POP AX
		SUB AX , DX
		MOV DX , AX
		PUSH DX
		MOV DX , 4[BP]
		PUSH DX
		CALL bar
		POP AX
		ADD AX , DX
		MOV DX , AX
		SUB SP , 0
		JMP foo_exit
		;<<
	if_end5:
	foo_exit:
	POP BP
	RET 4
	;<<
foo ENDP
bar PROC
;>>
	PUSH BP
	MOV BP , SP
	;Line 12: Relational operator checking
	MOV DX , 4[BP]
	PUSH DX
	;Line 12: integar = 0
	MOV DX , 0
	POP AX
	CMP AX , DX
	JE relop_is_ok_6
	MOV DX , 0
	JMP relop_end_7
	relop_is_ok_6:
	MOV DX , 1
	relop_end_7:
	CMP DX , 0
	JNZ after_or_10
	;Line 12: Relational operator checking
	MOV DX , 6[BP]
	PUSH DX
	;Line 12: integar = 0
	MOV DX , 0
	POP AX
	CMP AX , DX
	JE relop_is_ok_8
	MOV DX , 0
	JMP relop_end_9
	relop_is_ok_8:
	MOV DX , 1
	relop_end_9:
	after_or_10:
	CMP DX , 0
	JZ if_false11
	;>>
		;Line 13: integar = 1
		MOV DX , 1
		SUB SP , 0
		JMP bar_exit
		JMP if_end11
		;<<
	if_false11:
	;>>
		MOV DX , 6[BP]
		PUSH DX
		MOV DX , 4[BP]
		PUSH DX
		;Line 14: integar = 1
		MOV DX , 1
		POP AX
		SUB AX , DX
		MOV DX , AX
		PUSH DX
		CALL foo
		PUSH DX
		MOV DX , 6[BP]
		PUSH DX
		;Line 14: integar = 1
		MOV DX , 1
		POP AX
		SUB AX , DX
		MOV DX , AX
		PUSH DX
		MOV DX , 4[BP]
		PUSH DX
		CALL bar
		POP AX
		ADD AX , DX
		MOV DX , AX
		PUSH DX
		;Line 14: integar = 1
		MOV DX , 1
		POP AX
		ADD AX , DX
		MOV DX , AX
		SUB SP , 0
		JMP bar_exit
		;<<
	if_end11:
	bar_exit:
	POP BP
	RET 4
	;<<
bar ENDP
main PROC
PUSH BP
MOV BP , SP
;Line 21: DATA SEGMENT INITIALIZATION
MOV AX, @DATA
MOV DS, AX
SUB SP , 2
;Line 19: integar = 4
MOV DX , 4
PUSH DX
;Line 19: integar = 2
MOV DX , 2
PUSH DX
CALL foo
MOV -2[BP] , DX
MOV DX , -2[BP]
PUSH DX
CALL PRINTLN
ADD SP , 2
main_exit:
POP BP
;Line 21: EXIT 0
MOV AH, 4CH
INT 21H
RET 0
main ENDP
END main
