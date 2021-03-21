flex -o state.c wordcount.l
g++ state.c -lfl -o state.out
./state.out wordcount.txt
