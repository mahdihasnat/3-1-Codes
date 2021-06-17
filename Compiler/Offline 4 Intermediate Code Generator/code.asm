.MODEL SMALL
.STACK 100H
.DATA
x DW 1 DUP 0
y DW 1 DUP 0
z DW 1 DUP 0
a DW 2 DUP 0
b DW 3 DUP 0
q DW 2 DUP 0
t DW 1 DUP 0
.CODE
f PROC
MOV DX , 4[BP]
SUB SP , 2
SUB SP , 20
SUB SP , 2
SUB SP , 2
ADD SP , 2
ADD SP , 2
ADD SP , 22
f ENDP
main PROC
SUB SP , 2
SUB SP , 2
SUB SP , 4
SUB SP , 2
MOV DX , -8[BP]
MOV DX , t
;Line 23: integar = 2
MOV DX , 2
;Line 23: get array element from memory
SAL DX , 1
MOV BX , DX
MOV DX , PTR WORD b[BX]
;Line 24: integar = 1
MOV DX , 1
;Line 24: get array element from stack
PUSH BP
SAL DX , 1
NEG DX
ADD DX , -4
ADD BP , DX
MOV DX , PTR WORD [BP]
POP BP
;Line 25: Relational operator checking
;Line 25: integar = 2
MOV DX , 2
PUSH DX
;Line 25: integar = 3
MOV DX , 3
POP AX
CMP AX , DX
JL relop_is_ok_0
MOV DX , 0
relop_is_ok_0:
MOV DX , 1
MOV DX , x
PUSH DX
CALL PRINTLN
ADD SP , 10
main ENDP
END main
