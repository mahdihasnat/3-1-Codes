flex -o analyzer.cpp analyzer_instruction.l
g++ analyzer.cpp -lfl -o analyzer.out
./analyzer.out input.txt