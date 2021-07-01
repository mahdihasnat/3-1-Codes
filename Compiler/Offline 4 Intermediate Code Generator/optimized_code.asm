.MODEL SMALL
.STACK 1000H
.DATA
FIXED_POINT_MULTIPLIER DW 64H
.CODE
println_int PROC
    ;print word variable stored in stack

    ;    IF NUMBER < 0
    ;        PRINT - SIGN
	
	push bp 
	
	mov bp,sp
	
	mov bx , word ptr [bp + 4] ; bx = variable
	
    

    CMP bX , 0
    JGE println_int_positive_number ; IF variable >=0 THEN NO PRINTING

        
        MOV AH, 02H ; AG <- 02 , MODE TO PRINT CHARACTER FROM DL
        MOV DL, 002DH ; print -
        INT 21H
        
        NEG bx

	println_int_positive_number:


	mov ax,bx
	mov bx,10
	
    ;    DO
    ;        NUMBER /= 10
    ;        CNT ++
    ;        PUSH REMINDER
    ;    WHILE NUMBER!=0

    MOV CX , 0 ; CX = COUNTER

    MORE_TO_PRINT_int:
        ;CWD  ; CONVERT WORD AX TO DOUBLE WORD DX:AX
        MOV DX , 0 ; SINCE NUMBER IS POSITIVE NOW SO WE CAN SET DX = 0 , IT WILL HELP FOR CASE AX = -(2^15)
        
        DIV bx ;QUOTIENT IN AX , REMINDER IN DX

        PUSH DX ; PUSH  DX = REMINDER
        INC CX ; CNT++

        CMP AX , 0000H
        JNE MORE_TO_PRINT_int ;AX != 0

    ;   WHILE( CNT --)
    ;        PRINT( STACK.TOP())
    ;        STACK.POP()

    JCXZ println_int_exit ;IF CX IS ZERO THEN NOTING TO PRINT , THIS CASE WONT ARISE THOUGH

    println_int_print_digits:


            MOV AH, 02H ; AG <- 02 , MODE TO PRINT CHARACTER FROM DL
            POP DX
            ADD DL, '0'
            INT 21H


        LOOP println_int_print_digits

    println_int_exit:

    MOV AH, 02H ; AG <- 02 , MODE TO PRINT CHARACTER FROM DL
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    
    POP BP

    RET 2
    
println_int ENDP
println_float PROC
    ;print word variable stored in stack

    ;    IF NUMBER < 0
    ;        PRINT - SIGN
	
	push bp 
	
	mov bp,sp
	
	mov bx , word ptr [bp + 4] ; bx = variable
	
    

    CMP bX , 0
    JGE println_positive_number_float ; IF variable >=0 THEN NO PRINTING

        
        MOV AH, 02H ; AG <- 02 , MODE TO PRINT CHARACTER FROM DL
        MOV DL, 002DH ; print -
        INT 21H
        
        NEG bx

	println_positive_number_float:


	mov ax,bx
	mov bx,10
	
    ;    DO
    ;        NUMBER /= 10
    ;        CNT ++
    ;        PUSH REMINDER
    ;    WHILE NUMBER!=0

    MOV CX , 0 ; CX = COUNTER

    MORE_TO_PRINT_float:
        ;CWD  ; CONVERT WORD AX TO DOUBLE WORD DX:AX
        MOV DX , 0 ; SINCE NUMBER IS POSITIVE NOW SO WE CAN SET DX = 0 , IT WILL HELP FOR CASE AX = -(2^15)
        
        DIV bx ;QUOTIENT IN AX , REMINDER IN DX
        

        add dx , '0'
        PUSH DX ; PUSH dl where DX = REMINDER
        INC CX ; CNT++
           
        ; 987654.21
        
        ; if cx == 2 
           ;push .
        
           
        cmp cx , 2
        
        
        jne println_float_check_decmalpoint_end
            
            mov DX , '.'
            push DX
            inc cx
           
        println_float_check_decmalpoint_end:                       
        
        cmp cx , 4
        
        jl MORE_TO_PRINT_float
        
        CMP AX , 0000H
        JNE MORE_TO_PRINT_float ;AX != 0
        
        
        

    ;   WHILE( CNT --)
    ;        PRINT( STACK.TOP())
    ;        STACK.POP()

    JCXZ println_float_exit ;IF CX IS ZERO THEN NOTING TO PRINT , THIS CASE WONT ARISE THOUGH

    println_float_print_digits:


            MOV AH, 02H ; AG <- 02 , MODE TO PRINT CHARACTER FROM DL
            POP DX
            INT 21H


        LOOP println_float_print_digits

    println_float_exit:

    MOV AH, 02H ; AG <- 02 , MODE TO PRINT CHARACTER FROM DL
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    
    POP BP

    RET 2
    
println_float ENDP
one1 PROC
;>>
	PUSH BP
	MOV BP , SP
	SUB SP , 2
	;Line 4: float number = 1.10
	MOV CX , 110
	MOV -2[BP] , CX
	;Line 4: CX = assigned value
	PUSH CX
	CALL println_float
	;Line 4: integar = 1
	MOV CX , 1
	SUB SP , -2
	JMP one1_exit
	ADD SP , 2
	one1_exit:
	POP BP
	RET 0
	;<<
one1 ENDP
one2 PROC
;>>
	PUSH BP
	MOV BP , SP
	SUB SP , 2
	;Line 5: float number = 1.20
	MOV CX , 120
	MOV -2[BP] , CX
	;Line 5: CX = assigned value
	PUSH CX
	CALL println_float
	;Line 5: integar = 1
	MOV CX , 1
	SUB SP , -2
	JMP one2_exit
	ADD SP , 2
	one2_exit:
	POP BP
	RET 0
	;<<
one2 ENDP
zero1 PROC
;>>
	PUSH BP
	MOV BP , SP
	SUB SP , 2
	;Line 7: float number = 0.10
	MOV CX , 10
	MOV -2[BP] , CX
	;Line 7: CX = assigned value
	PUSH CX
	CALL println_float
	;Line 7: integar = 0
	MOV CX , 0
	SUB SP , -2
	JMP zero1_exit
	ADD SP , 2
	zero1_exit:
	POP BP
	RET 0
	;<<
zero1 ENDP
zero2 PROC
;>>
	PUSH BP
	MOV BP , SP
	SUB SP , 2
	;Line 8: float number = 0.20
	MOV CX , 20
	MOV -2[BP] , CX
	;Line 8: CX = assigned value
	PUSH CX
	CALL println_float
	;Line 8: integar = 0
	MOV CX , 0
	SUB SP , -2
	JMP zero2_exit
	ADD SP , 2
	zero2_exit:
	POP BP
	RET 0
	;<<
zero2 ENDP
main PROC
;>>
	PUSH BP
	MOV BP , SP
	;Line 38: DATA SEGMENT INITIALIZATION
	MOV AX, @DATA
	MOV DS, AX
	SUB SP , 2
	;Line 14: integar = 5
	MOV CX , 5
	MOV -2[BP] , CX
	;Line 14: CX = assigned value
	CALL one1
	JCXZ if_end2
	CALL zero1
	CMP CX , 0
	JNZ after_and_1
	CALL one2
	after_or_0:
	after_and_1:
	JCXZ if_end2
	;>>
		MOV CX , 1
		JMP if_end2
		;<<
	if_false2:
	;>>
		;<<
	if_end2:
	MOV CX , -2[BP]
	PUSH CX
	CALL println_int
	CALL one1
	CMP CX , 0
	JNZ after_or_3
	CALL one2
	after_or_3:
	JCXZ if_end4
	;>>
		MOV CX , 1
		JMP if_end4
		;<<
	if_false4:
	;>>
		;<<
	if_end4:
	MOV CX , -2[BP]
	PUSH CX
	CALL println_int
	CALL zero1
	CMP CX , 0
	JNZ after_or_5
	CALL zero2
	after_or_5:
	JCXZ if_end6
	;>>
		MOV CX , 1
		JMP if_end6
		;<<
	if_false6:
	;>>
		;<<
	if_end6:
	MOV CX , -2[BP]
	PUSH CX
	CALL println_int
	CALL zero1
	CMP CX , 0
	JNZ after_or_7
	CALL one2
	after_or_7:
	JCXZ if_end8
	;>>
		MOV CX , 1
		JMP if_end8
		;<<
	if_false8:
	;>>
		;<<
	if_end8:
	MOV CX , -2[BP]
	PUSH CX
	CALL println_int
	SUB SP , 2
	;Line 35: start of for loop
	;Line 24: integar = 0
	MOV CX , 0
	MOV -4[BP] , CX
	;Line 24: CX = assigned value
	for_loop12:
	;>>
		;Line 24: Relational operator checking
		MOV CX , -4[BP]
		PUSH CX
		;Line 24: integar = 5
		MOV CX , 5
		POP AX
		CMP AX , CX
		JL relop_is_ok9
		MOV CX , 0
		JMP relop_end9
		relop_is_ok9:
		MOV CX , 1
		relop_end9:
		JCXZ for_end12
		;>>
			;Line 35: start of for loop statement
			MOV CX , -4[BP]
			PUSH CX
			CALL println_int
			SUB SP , 2
			;Line 34: start of for loop
			MOV CX , -4[BP]
			PUSH CX
			;Line 29: integar = 1
			MOV CX , 1
			POP AX
			ADD AX , CX
			MOV CX , AX
			MOV -6[BP] , CX
			;Line 29: CX = assigned value
			for_loop11:
			;>>
				;Line 29: Relational operator checking
				MOV CX , -6[BP]
				PUSH CX
				MOV CX , -2[BP]
				POP AX
				CMP AX , CX
				JL relop_is_ok10
				MOV CX , 0
				JMP relop_end10
				relop_is_ok10:
				MOV CX , 1
				relop_end10:
				JCXZ for_end11
				;>>
					;Line 34: start of for loop statement
					SUB SP , 2
					MOV CX , -4[BP]
					PUSH CX
					;>>
						;Line 32: /
						MOV CX , -6[BP]
						PUSH CX
						;Line 32: float number = 10.00
						MOV CX , 1000
						POP AX
						IMUL FIXED_POINT_MULTIPLIER
						IMUL FIXED_POINT_MULTIPLIER
						IDIV CX
						MOV CX , AX
						;<<
					POP AX
					IMUL FIXED_POINT_MULTIPLIER
					ADD AX , CX
					MOV CX , AX
					MOV -8[BP] , CX
					;Line 32: CX = assigned value
					PUSH CX
					CALL println_float
					ADD SP , 2
					;<<
				;Line 34: start of for loop step
				MOV CX , -6[BP]
				MOV AX , CX
				ADD AX , 1
				MOV -6[BP] , AX
				JMP for_loop11
				;<<
			for_end11:
			ADD SP , 2
			;<<
		;Line 35: start of for loop step
		MOV CX , -4[BP]
		MOV AX , CX
		ADD AX , 1
		MOV -4[BP] , AX
		JMP for_loop12
		;<<
	for_end12:
	ADD SP , 4
	main_exit:
	POP BP
	;Line 38: EXIT 0
	MOV AH, 4CH
	INT 21H
	RET 0
	;<<
main ENDP
END main
