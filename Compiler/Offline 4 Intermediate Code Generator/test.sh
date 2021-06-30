for i in {1..11}
do
	cat "tests/test"$i".cpp"
	cat "tests/test"$i".cpp" > input.cpp
	make
	read x
done