.MODEL SMALL


.STACK 100H


.DATA
CR EQU 0DH
LF EQU 0AH


ONES_COMPLEMENT DB ?
LOWERCASE_PREVIOUS DB ?

INPUT_PROMPT DB CR,LF,'Press an uppercase key:$'
OUTPUT_PROMPT1 DB CR,LF,'Previous character in lowercase format is $'
OUTPUT_PROMPT2 DB CR,LF,"1's complement of input character is $"

.CODE

MAIN PROC
	;DATA SEGMENT INITIALIZATION
    MOV AX, @DATA
    MOV DS, AX

    ; prompt for input
    MOV AH, 09H ; dosplay string function
    LEA DX , INPUT_PROMPT
    INT 21H

    ;taking uppercase character input to LOWERCASE_PREVIOUS , ONES_COMPLEMENT
    MOV AH, 01H
    INT 21H
    MOV LOWERCASE_PREVIOUS, AL
    MOV ONES_COMPLEMENT , AL

    ;converting to lowercase character -1 = 20H-01H
    ADD LOWERCASE_PREVIOUS, 1FH

    ;OUTPUT lowercase previous character
    ; prompt
    MOV AH, 09H ; dosplay string function
    LEA DX , OUTPUT_PROMPT1
    INT 21H

    ; character
    MOV AH , 02H
    MOV DL , LOWERCASE_PREVIOUS
    INT 21H


    ;computing 1's complement
    NEG ONES_COMPLEMENT    ; taking 2's complement
    ;SUB ONES_COMPLEMENT , 1H ; subtracting 1 from 2's complement 
    DEC ONES_COMPLEMENT ; subtracting 1 from 2's complement 


    ; OUTPUT 1's complement
    ;prompt
    MOV AH, 09H ; dosplay string function
    LEA DX , OUTPUT_PROMPT2
    INT 21H

    ;character
    MOV AH , 02H
    MOV DL , ONES_COMPLEMENT
    INT 21H
    
    
    ;Return control to dos
    MOV AH, 4CH
    INT 21H


MAIN ENDP
    END MAIN
