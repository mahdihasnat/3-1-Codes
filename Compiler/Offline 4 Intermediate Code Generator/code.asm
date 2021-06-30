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
main PROC
;>>
	PUSH BP
	MOV BP , SP
	;Line 11: DATA SEGMENT INITIALIZATION
	MOV AX, @DATA
	MOV DS, AX
	SUB SP , 2
	SUB SP , 2
	;>>
		;Line 7: /
		;Line 7: integar = 10
		MOV CX , 10
		PUSH CX
		;Line 7: integar = 7
		MOV CX , 7
		POP AX
		CWD
		IDIV CX
		MOV CX , AX
		;<<
	MOV -2[BP] , CX
	;Line 7: CX = assigned value
	MOV CX , -2[BP]
	PUSH CX
	CALL println_int
	;>>
		;Line 8: /
		;Line 8: integar = 10
		MOV CX , 10
		PUSH CX
		;Line 8: float number = 7.00
		MOV CX , 700
		POP AX
		IMUL FIXED_POINT_MULTIPLIER
		IMUL FIXED_POINT_MULTIPLIER
		IDIV CX
		MOV CX , AX
		;<<
	MOV -4[BP] , CX
	;Line 8: CX = assigned value
	MOV CX , -4[BP]
	PUSH CX
	CALL println_float
	;>>
		;Line 9: /
		;Line 9: float number = 10.00
		MOV CX , 1000
		PUSH CX
		;Line 9: integar = 7
		MOV CX , 7
		POP AX
		CWD
		IDIV CX
		MOV CX , AX
		;<<
	MOV -4[BP] , CX
	;Line 9: CX = assigned value
	MOV CX , -4[BP]
	PUSH CX
	CALL println_float
	;>>
		;Line 10: /
		;Line 10: float number = 10.00
		MOV CX , 1000
		PUSH CX
		;Line 10: float number = 7.00
		MOV CX , 700
		POP AX
		IMUL FIXED_POINT_MULTIPLIER
		IDIV CX
		MOV CX , AX
		;<<
	MOV -4[BP] , CX
	;Line 10: CX = assigned value
	MOV CX , -4[BP]
	PUSH CX
	CALL println_float
	ADD SP , 4
	main_exit:
	POP BP
	;Line 11: EXIT 0
	MOV AH, 4CH
	INT 21H
	RET 0
	;<<
main ENDP
END main
