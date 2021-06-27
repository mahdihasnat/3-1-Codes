// if else 
int x;
int mema[5];
int main()
{
	int i;
	for( i=0;i<5 ; i = i+1)
		mema[i]=i+1;
	x=10;
	int y;
	y = -1;
	if( x == 2)
		y=mema[2];
	else y = mema[4];
	println(y); // 5
	if( x == 10)
		y=mema[2];
	else y = mema[4];
	println(y); // 3
	
}