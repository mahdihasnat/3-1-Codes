//  short circuit and 
// short circuit or

int foo()
{
	int x;
	x=1;
	println(x);
	return x;
}

void main()
{

	int ok;
	ok =2;
	if(0 && foo())
	{
		println(ok);// prints nothing
	}
	
	int ok2;
	ok2 = 4;
	if(1 || foo())
	{
		println(ok2); // print 4 only
	}
	

}