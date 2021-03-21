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
OPERAND1 DW ?
OPERAND2 DW ?

OVERFLOW_MSG DB CR , LF , 'Overflow occurred $'
WRONG_OPERATOR_MSG DB CR, LF , 'Wrong operator$'
REMINDER_MSG DB CR ,LF , 'REMINDER:$'
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

PUT_OVERFLOW_MSG PROC

    PUSH AX
    PUSH BX
    PUSH CX 
    PUSH DX
    PUSHF

        LEA DX , OVERFLOW_MSG
        MOV AH,09H ; MOD TO PRINT STRING ENDDED WITH '$' , STRING LOCATION GIVEN IN DX
        INT 21H ; PRINT

    POPF
    POP DX
    POP CX
    POP BX
    POP AX
    
    ;EXIT PROGRAM
    MOV AH, 4CH
    INT 21H


    RET
PUT_OVERFLOW_MSG ENDP

PUT_REMINDER_MSG PROC

    PUSH AX
    PUSH BX
    PUSH CX 
    PUSH DX
    PUSHF

        LEA DX , REMINDER_MSG
        MOV AH,09H ; MOD TO PRINT STRING ENDDED WITH '$' , STRING LOCATION GIVEN IN DX
        INT 21H ; PRINT

    POPF
    POP DX
    POP CX
    POP BX
    POP AX

    RET
PUT_REMINDER_MSG ENDP

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
    
	CALL GET_NUMBER_WORD ; GET NUMBER INTO BX
	MOV OPERAND1 , BX

    CALL PUT_NEWLINE

    MOV AH , 01H ; AH <- 01 ,MODE TO TAKE CHARACTER AS ASCII WHEN INT 21H IS CALLED
    INT 21H ; CALLING INTURRAPT TO TAKE INPUT , ASCII VALUE WILL BE AT #AL

    CALL PUT_NEWLINE

    CMP AL , '+'
    JE ADDITION_OPERATION

    CMP AL , '-'
    JE SUBTRACTION_OPERATION
    
    CMP AL , '*'
    JE MULTIPLICATION_OPERATION

    CMP AL ,'/'
    JE DIVISION_OPERATION

    CMP AL , 'q'
    JE EXIT_MAIN

    JMP WRONG_OPERATION


    

    ADDITION_OPERATION:
        CALL GET_NUMBER_WORD ; GET NUMBER INTO BX
        MOV OPERAND2 , BX

        MOV DX , 0
        MOV AX , OPERAND1
        ADD AX , OPERAND2
        ;        IF OVERFLOW THEN PRINT OVERFLOW MSG
        ;        ELSE PRINT NUMBER
        
        JO OVERFLOW_OCCURRED

        CALL PUT_DECIMAL_WORD
        JMP EXIT_MAIN

    SUBTRACTION_OPERATION:
        CALL GET_NUMBER_WORD ; GET NUMBER INTO BX
        MOV OPERAND2 , BX

        MOV DX , 0
        MOV AX , OPERAND1
        SUB AX , OPERAND2
        ;        IF OVERFLOW THEN PRINT OVERFLOW MSG
        ;        ELSE PRINT NUMBER
        
        JO OVERFLOW_OCCURRED

        CALL PUT_DECIMAL_WORD
        JMP EXIT_MAIN

    MULTIPLICATION_OPERATION:
        CALL GET_NUMBER_WORD ; GET NUMBER INTO BX
        MOV OPERAND2 , BX
        
        MOV AX , OPERAND1
        IMUL OPERAND2

        
        ; CHECK ANSWER FITS IN AX 
        ; convert lower word to double word , if upper section is same as previous  then no overflow occurred  , 
        ; After IMUL, CF/OF = 0 if the upper half of the result is the sign extension of the lower half 
        ;                       (this means that the bits of the upper half are the same as the :;ign bit of the lower half).
        ;                   = 1 otherwise.
        
        JO OVERFLOW_OCCURRED

        CALL PUT_DECIMAL_WORD

        JMP EXIT_MAIN

    DIVISION_OPERATION:
        CALL GET_NUMBER_WORD ; GET NUMBER INTO BX
        MOV OPERAND2 , BX
        
        MOV AX ,OPERAND1
        CWD 
        IDIV OPERAND2

        CALL PUT_DECIMAL_WORD

        CALL PUT_REMINDER_MSG

        MOV AX , DX 
        CALL PUT_DECIMAL_WORD

        JMP EXIT_MAIN
    
    WRONG_OPERATION:
        LEA DX , WRONG_OPERATOR_MSG
        MOV AH,09H ; MOD TO PRINT STRING ENDDED WITH '$' , STRING LOCATION GIVEN IN DX
        INT 21H ; PRINT

        JMP EXIT_MAIN

    OVERFLOW_OCCURRED:
        CALL PUT_OVERFLOW_MSG

        JMP EXIT_MAIN

    EXIT_MAIN:


    ;Return 0
    MOV AH, 4CH
    INT 21H


MAIN ENDP
    END MAIN
