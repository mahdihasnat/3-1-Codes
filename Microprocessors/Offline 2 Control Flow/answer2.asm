.MODEL SMALL


.STACK 100H


.DATA
    CR EQU 0DH
    LF EQU 0AH

    IS_DIGIT DB 0
    IS_UPPER DB 0
    IS_LOWER DB 0

    VALID_MSG DB CR , LF , 'Valid password$'
    INVALID_MSG DB CR , LF , 'Invalid password$'

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX

    ; [21h  [30H DIG 39H] , [41H UPPER 5AH] , [61H lower 5AH] 7EH]

    MOV AH , 01H ; WARNING DONT CHANGE VALUE OF AH
    INPUT:
        INT 21H ; INPUT STORED IN #AL AS ASCII FORMAT

        CMP AL , 30H
        JL CHECK_DIGIT_COMPLETE
        CMP AL , 39H
        JG CHECK_DIGIT_COMPLETE
            MOV IS_DIGIT , 1 ; 30H <= AL <= 29H

        CHECK_DIGIT_COMPLETE:

        CMP AL , 41H
        JL CHECK_UPPER_COMPLETE
        CMP AL , 5AH
        JG CHECK_UPPER_COMPLETE

            MOV IS_UPPER , 1 ; 41H <= AL <= 51H

        CHECK_UPPER_COMPLETE:

        CMP AL , 61H
        JL CHECK_LOWER_COMPLETE
        CMP AL , 7AH
        JG CHECK_LOWER_COMPLETE

            MOV IS_LOWER , 1 ; 61H <= AL <= 7AH

        CHECK_LOWER_COMPLETE:

        CMP AL , 21H
        JL ENDINPUT
        CMP AL , 7EH
        JG ENDINPUT

            JMP INPUT ; 21<= AL <= 7E

    ENDINPUT:

    MOV AL , IS_DIGIT ; AL <- IS_DIGIT
    ADD AL , IS_UPPER ; AL <- IS_DIGIT + IS_UPPER
    ADD AL , IS_LOWER ; AL <- IS_DIGIT + IS_UPPER + IS_LOWER

;    if is_digit + is_upper + is_lower == 3
;        valid
;    else
;        invalid

    CMP AL , 03H
    JNE INVALID

    VALID:
        LEA DX , VALID_MSG
        JMP PRINT
    INVALID:
        LEA DX , INVALID_MSG
        JMP PRINT
    PRINT:
        MOV AH,09H ; MOD TO PRINT STRING ENDDED WITH '$' , STRING LOCATION GIVEN IN DX
        INT 21H ; PRINT

    ;Return 0
    MOV AH, 4CH
    INT 21H


MAIN ENDP
    END MAIN
