start=$(date +%s.%N)
flex -o analyzer.cpp 1705003.l
g++ analyzer.cpp -lfl -g -o analyzer.out
#valgrind --leak-check=full -s --show-leak-kinds=all ./analyzer.out $1 1705003_log.txt 1705003_token.txt
./analyzer.out $1 1705003_log.txt 1705003_token.txt
dur=$(echo "$(date +%s.%N) - $start" | bc)
printf "Execution time: %.6f seconds\n" $dur