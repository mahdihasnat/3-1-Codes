CC = g++
LEX = flex
YACC = bison
CPPFLAGS = -g

all: y.o l.o a.out run
	
# ${YACC} -d -y -o y.tab.cpp parser.y
# ${LEX}  -o lex.yy.cpp scanner.l 
# ${CC} ${CPPFLAGS} -c -o l.o lex.yy.cpp
# ${CC} ${CPPFLAGS} -c -o y.o y.tab.cpp
# ${CC} ${CPPFLAGS} y.o l.o -lfl
# ./a.out input.txt log.txt error.txt

l.o : y.tab.h scanner.l 
	${LEX}  scanner.l
	${CC} ${CPPFLAGS} -c -o l.o lex.yy.c

y.o: parser.y SymbolTable.h SymbolInfo.h ScopeTable.h ParserFunctions.h
	${YACC} -d -y --report=all parser.y
	${CC} ${CPPFLAGS} -c -o y.o y.tab.c

a.out: l.o y.o
	${CC} ${CPPFLAGS} y.o l.o -lfl

run:
	valgrind --leak-check=full -s --show-leak-kinds=all ./a.out input.txt log.txt error.txt
#./a.out input.txt log.txt error.txt

clean: 
	rm -f *.out
	rm -f *.o
	rm -f lex.yy.c
	rm -f y.tab.c
	rm -f y.tab.h
	rm -f y.output