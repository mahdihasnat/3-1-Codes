yacc -d -y -v 1705003.y
echo '1'
g++ -w -c -o y.o y.tab.c
echo '2'
flex 1705003.l
echo '3'
g++ -w -c -o l.o lex.yy.c
echo '4'
g++ -o a.out y.o l.o ReturnType.cpp Code.cpp -lfl
echo '5'
./a.out $1
