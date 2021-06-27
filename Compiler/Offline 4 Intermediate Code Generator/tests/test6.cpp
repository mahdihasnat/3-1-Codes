// infinite while 1 loop
// decrement of global int variable
// decrement of global int array
// decrement of local int variable
int x;
int mema[10];
int main()
{
	
	int i;
	i=0;

	while (1)
	{
		
		int z;
		z = i--;
		println(z); // 0 , -1 ,  -2 ,-3 ..
		x--;
		println(x); // -1,  -2 , -3 , ..
		int j;
		mema[5]--;
		j=mema[5];
		println(j); //  -1 , -2  , -3
	}
	
	println(x);
}