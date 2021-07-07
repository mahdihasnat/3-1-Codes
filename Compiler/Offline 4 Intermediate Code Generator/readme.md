- int and float ( fixed point representation) variable needs 16 bit memory ( word in 8086)
- return value is stored in <del>DX</del> CX
- local variable is stored in stack, displacement with respect to base pointer is stored in symboltable
- BP is unchanged upon procedure call
- new bp is generated in begining of procedure
- *variable* nonterminal does not contain read/write code

**reminder** :
- put parenthasis data memory variable declaration `var_name DW 1 DUP (0000H)`
- Push arguments before calling function, this is implemented in arguments rule
- end of line sequence should be LF in library .asm file , like println_int.asm
# Optimization
- Removed redundant assignment like `x=x;`
- Shortened Jump chain like `1 && ( 0 || 1)`
- Removed uncalled procedure
- Removed Unreachable code like `return 0; println(x);`

# Suggestion
I know u'r searching for treasure
Go use `MakeFile`
