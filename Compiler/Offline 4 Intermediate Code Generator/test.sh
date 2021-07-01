for i in {1..12}
do
	cat "tests/test"$i".cpp"
	cat "tests/test"$i".cpp" > input.cpp
	echo "testing "$i" th test"
	make
	read x
done
make clean