.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH
POSITIVE EQU 00H
NEGATIVE EQU 01H
MINUS_CHAR EQU  002DH
TEN DW 10

N EQU 2
M EQU 2

ARRAY1 DW 2 DUP (0)
        DW 2 DUP (0)
ARRAY2 DW 2 DUP ( 0)
        DW 2 DUP ( 0)
ARRAY3 DW 2 DUP ( 0)
        DW 2 DUP ( 0)

.CODE

PUT_NEWLINE PROC

    PUSH AX
    PUSH BX
    PUSH CX 
    PUSH DX
    PUSHF

        MOV AH, 02H ; AG <- 02 , MODE TO PRINT CHARACTER FROM DL
        MOV DL, CR
        INT 21H
        MOV DL, LF
        INT 21H

    POPF
    POP DX
    POP CX
    POP BX
    POP AX

    RET
PUT_NEWLINE ENDP

PUT_SPACE PROC

    PUSH AX
    PUSH BX
    PUSH CX 
    PUSH DX
    PUSHF

        MOV AH, 02H ; AG <- 02 , MODE TO PRINT CHARACTER FROM DL
        MOV DL, ' '
        INT 21H

    POPF
    POP DX
    POP CX
    POP BX
    POP AX

    RET
PUT_SPACE ENDP

PUT_DECIMAL_WORD PROC
    ; PRINT NUMBER STORED IN AX
    PUSH AX
    PUSH BX
    PUSH CX 
    PUSH DX
    PUSHF

    ;    IF NUMBER < 0
    ;        PRINT - SIGN


    CMP AX , 0
    JGE CHECKED_SIGN ; IF AX>=0 THEN NO PRINTING

        PUSH AX
        PUSH DX

            MOV AH, 02H ; AG <- 02 , MODE TO PRINT CHARACTER FROM DL
            MOV DL, MINUS_CHAR
            INT 21H

        POP DX
        POP AX

        NEG AX


    CHECKED_SIGN:



    ;    DO
    ;        NUMBER /= 10
    ;        CNT ++
    ;        PUSH REMINDER
    ;    WHILE NUMBER!=0

    MOV CX , 0 ; CX = COUNTER

    MORE_TO_PRINT:
        ;CWD  ; CONVERT WORD AX TO DOUBLE WORD DX:AX
        MOV DX , 0 ; SINCE NUMBER IS POSITIVE NOW SO WE CAN SET DX = 0 , IT WILL HELP FOR CASE AX = -(2^15)
        DIV TEN ;QUOTIENT IN AX , REMINDER IN DX

        PUSH DX ; PUSH  DX = REMINDER
        INC CX ; CNT++

        CMP AX , 0000H
        JNE MORE_TO_PRINT ;AX != 0

    ;   WHILE( CNT --)
    ;        PRINT( STACK.TOP())
    ;        STACK.POP()

    JCXZ EXIT_PUT_DECIMAL_WORD ;IF CX IS ZERO THEN NOTING TO PRINT , THIS CASE WONT ARISE THOUGH

    PRINT_DIGITS:


            MOV AH, 02H ; AG <- 02 , MODE TO PRINT CHARACTER FROM DL
            POP DX
            ADD DL, '0'
            INT 21H


        LOOP PRINT_DIGITS

    EXIT_PUT_DECIMAL_WORD:

    POPF
    POP DX
    POP CX
    POP BX
    POP AX

    RET
PUT_DECIMAL_WORD ENDP

PUT_ARRAY_WORD PROC
    ; array location stored in SI
    
    PUSH SI
    PUSH AX
    PUSH BX
    PUSH CX 
    PUSH DX
    PUSHF

    CALL PUT_NEWLINE
    ;FOR(I = 0; I< N; I++)
    ;    FOR(J=0;J<M;J++

    MOV CX , N

    FOR_REV_I_PUT:
        PUSH CX

            MOV CX , M 
            FOR_REV_J_PUT:
                
                MOV AX ,word ptr [SI]
                CALL PUT_DECIMAL_WORD
                CALL PUT_SPACE
                ADD SI,2
                LOOP FOR_REV_J_PUT

        CALL PUT_NEWLINE

        POP CX
        LOOP FOR_REV_I_PUT


    POPF
    POP DX
    POP CX
    POP BX
    POP AX
    POP SI
    
    RET
PUT_ARRAY_WORD ENDP

GET_ARRAY_WORD PROC
    ; array location stored in SI
    
    PUSH SI
    PUSH AX
    PUSH BX
    PUSH CX 
    PUSH DX
    PUSHF
    
    ;for i= 0; i< n; i++
    ;    for j= 0 ; j< n; j++
    ;        scan array[i][j]

    MOV CX , N
    FOR_REV_I_GET:
        PUSH CX

            MOV CX , M
            FOR_REV_J_GET:

                    ; SCAN  ARRAY[N-I][M-J]
                    MOV AH , 01H ; AH <- 01 ,MODE TO TAKE CHARACTER AS ASCII WHEN INT 21H IS CALLED
                    INT 21H ; CALLING INTURRAPT TO TAKE INPUT , ASCII VALUE WILL BE AT #AL
                    SUB AL ,'0'
                    MOV AH,0
                    MOV WORD PTR[SI] , AX
                    ADD SI,2
                    CALL PUT_SPACE
            
                LOOP FOR_REV_J_GET
            
        CALL PUT_NEWLINE

        POP CX 
        LOOP FOR_REV_I_GET
    

    POPF
    POP DX
    POP CX
    POP BX
    POP AX
    POP SI
    RET
GET_ARRAY_WORD ENDP

CALCULATE_SUM PROC
    
    ;ARRAY3 = ARRAY1 + ARRAY2

    PUSH AX
    PUSH BX
    PUSH CX 
    PUSH DX
    PUSHF


    ;for i= 0; i< n; i++
    ;    for j= 0 ; j< n; j++
    ;        ARRAY3[I][J] = ARRAY1[I][J] + ARRAY2[I][J]
    ; ARRAY[BX|BP][SI|DI] -> BASED INDEX
    ; OR ARRAY[BX|BP] -> BASED [IF BX IS USED DS CONTAINS SEGMENT ] [IF BP IS USED SS CONTAINS SEGMENT]
    
    XOR BX,BX   ;BX = 0 , BX = INDEX TO ARRAY

    MOV CX , N
    FOR_REV_I_CALC:
        PUSH CX 
            
            MOV CX, M
            FOR_REV_J_CALC:
                
                    ;A3[N-I][M-J] = A1[N-I][M-J] + A2[N-I][M-J]
                    ;BX = (N-I)*M+(M-J)
                    MOV AX , ARRAY1[BX]
                    ADD AX , ARRAY2[BX]
                    MOV ARRAY3[BX] ,AX
                    ADD BX , 2

                LOOP FOR_REV_J_CALC
        POP CX 
        LOOP FOR_REV_I_CALC



    POPF
    POP DX
    POP CX
    POP BX
    POP AX

    RET
CALCULATE_SUM ENDP

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX
     
    

    LEA SI , ARRAY1 
    CALL GET_ARRAY_WORD
    
    LEA SI , ARRAY2 
    CALL GET_ARRAY_WORD

    CALL CALCULATE_SUM

    LEA SI , ARRAY3
    CALL PUT_ARRAY_WORD

    ;Return 0
    MOV AH, 4CH
    INT 21H


MAIN ENDP
    END MAIN
