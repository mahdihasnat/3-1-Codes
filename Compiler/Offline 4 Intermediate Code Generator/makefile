CC = g++
LEX = flex
YACC = bison
CPPFLAGS =

all: y.o l.o a.out run
	
# ${YACC} -d -y -o y.tab.cpp 1705003.y
# ${LEX}  -o lex.yy.cpp 1705003.l 
# ${CC} ${CPPFLAGS} -c -o l.o lex.yy.cpp
# ${CC} ${CPPFLAGS} -c -o y.o y.tab.cpp
# ${CC} ${CPPFLAGS} y.o l.o -lfl
# ./a.out input.txt log.txt error.txt

l.o : y.tab.h 1705003.l 
	${LEX}  1705003.l
	${CC} ${CPPFLAGS} -c -o l.o lex.yy.c

y.o: 1705003.y SymbolTable.h SymbolInfo.h ScopeTable.h ParserFunctions.h
	${YACC} -d -y --report=all 1705003.y
	${CC} ${CPPFLAGS} -c -o y.o y.tab.c
# r.o: ReturnType.cpp
# 	${CC} ${CPPFLAGS} -c -o r.o ReturnType.cpp

a.out: l.o y.o
	${CC} ${CPPFLAGS} y.o l.o -lfl ReturnType.cpp Code.cpp

run:
#	valgrind --leak-check=full -s --show-leak-kinds=all ./a.out input.txt 
	./a.out input.txt 

clean: 
	rm -f *.out
	rm -f *.o
	rm -f lex.yy.c
	rm -f y.tab.c
	rm -f y.tab.h
	rm -f y.output