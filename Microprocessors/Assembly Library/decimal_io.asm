.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH

POSITIVE EQU 00H
NEGATIVE EQU 01H
MINUS_CHAR EQU  002DH

SIGN DB ?

CHAR DW ?
TEN DW 10


.CODE


GET_NUMBER_WORD PROC

    ; RETURN SIGNED NUMBER FROM INPUT IN BX


    PUSH AX
    PUSH CX
    PUSH DX
    PUSHF

    ;    WHILE  CIN>>CHAR
    ;        IF CHAR == '\n' BREAK
    ;        ELSE IF CHAR IN ['0','9']  ANSWER *= 10 , ANSWER += CHAR-'0'
    ;        ELSE IF ANSWER = 0 AND CHAR  EQUAL (+ , -) SIGN = CHAR

    MOV SIGN , POSITIVE ; SET SIGN AS POSITIVE

    MOV BX , 0

    OUTER_WHILE:

        MOV AH , 01H ; AH <- 01 ,MODE TO TAKE CHARACTER AS ASCII WHEN INT 21H IS CALLED
        INT 21H ; CALLING INTURRAPT TO TAKE INPUT , ASCII VALUE WILL BE AT #AL

		MOV AH , 0 ; RESULT IS IN AL , so ax now contains 00al
        MOV CHAR , AX ;

            CMP CHAR , CR
            JE EXIT_OUTER_WHILE ; if char is new line then exit while loop  , go to end of procedure

            CMP CHAR , '0'
            JL CHECKED_DIGIT ; char < '0' not a number

            CMP CHAR ,'9'
            JG CHECKED_DIGIT ; char > '9' not a number

                                ; '0'<= char <= '9'
                SUB CHAR , '0'  ; GET DIGIT FROM CHAR
                MOV AX , BX     ; TRANSFER ANSWER FROM BX TO AX
                MUL TEN			; ANSWER *= 10
                ADD AX , CHAR   ; ANSWER += CHAR-'0'
                MOV BX ,AX      ; STORE ANSWER TO BX

            CHECKED_DIGIT:

                            ;CHECK FOR - SIGN AT STARTING OF NUMBER
            CMP CHAR , MINUS_CHAR    ;
            JNE ENDIF

            CMP BX , 0
            JNE ENDIF

            MOV SIGN , NEGATIVE ; MAKE NUMBER NEGATIVE

        ENDIF:

        JMP OUTER_WHILE


    EXIT_OUTER_WHILE:


    ;    IF SIGN IS NEGATIVE
    ;        ANSWER *= -1
    CMP SIGN , NEGATIVE
    JNE EXIT_GETNUMBER ;IF SIGN != NEGATIVE

                    ; SIGN == NEGATIVE
        NEG BX


    EXIT_GETNUMBER:


    POPF
    POP DX
    POP CX
    POP AX

    RET

GET_NUMBER_WORD ENDP

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

PUT_DECIMAL_WORD PROC
    ; PRINT NUMBER STORED IN AX
    PUSH AX
    PUSH BX
    PUSH CX 
    PUSH DX
    PUSHF

    CALL PUT_NEWLINE


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

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX

	CALL GET_NUMBER_WORD
	MOV AX,BX
	CALL PUT_DECIMAL_WORD

    ;Return 0
    MOV AH, 4CH
    INT 21H


MAIN ENDP
    END MAIN