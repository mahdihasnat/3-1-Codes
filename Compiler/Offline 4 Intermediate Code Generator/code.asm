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
f PROC
;>>
	PUSH BP
	MOV BP , SP
	;>>
		;Line 2: *
		;Line 2: integar = 2
		MOV CX , 2
		PUSH CX
		MOV CX , 4[BP]
		POP AX
		IMUL CX
		MOV CX , AX
		;<<
	SUB SP , 0
	JMP f_exit
	;Line 3: integar = 9
	MOV CX , 9
	MOV 4[BP] , CX
	;Line 3: CX = assigned value
	f_exit:
	POP BP
	RET 2
	;<<
f ENDP
g PROC
;>>
	PUSH BP
	MOV BP , SP
	SUB SP , 2
	MOV CX , 4[BP]
	PUSH CX
	CALL f
	PUSH CX
	MOV CX , 4[BP]
	POP AX
	ADD AX , CX
	MOV CX , AX
	PUSH CX
	MOV CX , 6[BP]
	POP AX
	ADD AX , CX
	MOV CX , AX
	MOV -2[BP] , CX
	;Line 8: CX = assigned value
	MOV CX , -2[BP]
	SUB SP , -2
	JMP g_exit
	ADD SP , 2
	g_exit:
	POP BP
	RET 4
	;<<
g ENDP
main PROC
;>>
	PUSH BP
	MOV BP , SP
	;Line 19: DATA SEGMENT INITIALIZATION
	MOV AX, @DATA
	MOV DS, AX
	SUB SP , 2
	SUB SP , 2
	;Line 14: integar = 1
	MOV CX , 1
	MOV -2[BP] , CX
	;Line 14: CX = assigned value
	;Line 15: integar = 2
	MOV CX , 2
	MOV -4[BP] , CX
	;Line 15: CX = assigned value
	MOV CX , -4[BP]
	PUSH CX
	MOV CX , -2[BP]
	PUSH CX
	CALL g
	MOV -2[BP] , CX
	;Line 16: CX = assigned value
	MOV CX , -2[BP]
	PUSH CX
	CALL println_int
	;Line 18: integar = 0
	MOV CX , 0
	SUB SP , -4
	JMP main_exit
	ADD SP , 4
	main_exit:
	POP BP
	;Line 19: EXIT 0
	MOV AH, 4CH
	INT 21H
	RET 0
	;<<
main ENDP
END main
