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

l.o : y.tab.hpp scanner.l
	${LEX} -o lex.yy.cpp scanner.l
	${CC} ${CPPFLAGS} -c -o l.o lex.yy.cpp

y.o: parser.y
	${YACC} -d -y -o y.tab.cpp parser.y
	${CC} ${CPPFLAGS} -c -o y.o y.tab.cpp

a.out: l.o y.o
	${CC} ${CPPFLAGS} y.o l.o -lfl

run:
	valgrind --leak-check=full -s --show-leak-kinds=all ./a.out input.txt log.txt error.txt
#./a.out input.txt log.txt error.txt

clean: 
	rm -f *.out
	rm -f *.o
	rm -f y.tab.cpp
	rm -f y.tab.hpp