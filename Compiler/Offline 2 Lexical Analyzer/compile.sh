flex -o analyzer.cpp 1705003.l
g++ analyzer.cpp -lfl -g -o analyzer.out
#valgrind --leak-check=full -s --show-leak-kinds=all ./analyzer.out $1 1705003_log.txt 1705003_token.txt
./analyzer.out $1 1705003_log.txt 1705003_token.txt