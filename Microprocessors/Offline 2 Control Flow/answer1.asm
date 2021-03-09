.MODEL SMALL


.STACK 100H


.DATA
    CR EQU 0DH
    LF EQU 0AH

    ALL_EQUAL_MSG DB CR ,LF ,'All the numbers are equal$'
    SECOND_MAX DB -2
    MAX DB -1
    ITR DB 3

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX

    ;loop 3 times , take-number -> update-answer

    MOV AH , 01H ; AH <- 01 ,MODE TO TAKE CHARACTER AS ASCII WHEN INT 21H IS CALLED
    ;ITR <-3  GONNA TAKE 3 NUMBER
    OUTER_WHILE:

        INT 21H ; CALLING INTURRAPT TO TAKE INPUT , ASCII VALUE WILL BE AT #AL
        SUB AL , '0' ; MAKING AL AS NUMBER

    ;    PSEUDOCODE TO MAINTAIN SECOND_MAX AND MAX WITH INPUT
    ;    if max < input
    ;        second_max = max
    ;        max = input
    ;    else if  second_max < input < max
    ;        second_max = input

        ;MOV AL , INPUT ;BL <- input

        CMP AL , MAX
        JG IF_THEN ; if input > max goto if_then
        JE END_IF ; if input  == max equal go to end_if

        CMP AL,SECOND_MAX
        JG ELSE_IF_THEN ;implicitly input< max if input > second_max  goto else_if_then
        JMP END_IF

        IF_THEN: ;if max < input

            MOV CL , MAX ;CL <- MAX
            MOV SECOND_MAX , CL ; second_MAX <- CL <- MAX

            MOV MAX ,AL ; MAX <- BL <- INPUT

            JMP END_IF

        ELSE_IF_THEN: ; if second_max < input < max

            MOV SECOND_MAX , AL ; SECOND_MAX <- BL <- INPUT

            JMP END_IF

        END_IF:

    DEC ITR ; ITR--
    JNZ OUTER_WHILE ; CONTINUE UPTO ZERO

     ; END OF INPUT

    MOV AH,02H ; SETUP TO PRINT ONE CHARACTER

    MOV DL,CR
    INT 21H

    MOV DL,LF
    INT 21H
    ;PRINTED NEWLINE

    ; IF SECOND_MAX = -2 THEN ALL ARE EQUAL
    ; ELSE PRINT SECOND_MAX

    CMP SECOND_MAX , 0FFH ; 0FFH  =  -2 IN BYTE

    JNZ PRINT_IF_ELSE_THEN

    PRINT_IF_THEN: ; SECOND_MAX  == -2

        LEA DX, ALL_EQUAL_MSG
        MOV AH, 09H

        JMP PRINT_END_IF

    PRINT_IF_ELSE_THEN: ; 0 <= SECOND_MAX

        MOV DL,SECOND_MAX
        ADD DL,'0'
        MOV AH ,02H

        JMP PRINT_END_IF

    PRINT_END_IF:

        INT 21H ; PRINT

    ;Return 0
    MOV AH, 4CH
    INT 21H


MAIN ENDP
    END MAIN
