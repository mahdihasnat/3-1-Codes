#!/bin/bash

set -e 

bison -d -y -o y.tab.cpp parser.y 
echo 'Generated the parser Cpp file as well the hpp header file'

flex  -o lex.yy.cpp scanner.l 
echo 'Generated the scanner Cpp file'
g++  -c -o l.o lex.yy.cpp
# # if the above command doesn't work try g++ -fpermissive -w -c -o l.o lex.yy.c
echo 'Generated the scanner object file'

g++ -g  -c -o y.o y.tab.cpp
echo 'Generated the parser object file'

g++ y.o l.o -lfl
echo 'All ready, running'
#valgrind --leak-check=full -s --show-leak-kinds=all ./a.out input.txt log.txt error.txt
./a.out input.txt log.txt error.txt