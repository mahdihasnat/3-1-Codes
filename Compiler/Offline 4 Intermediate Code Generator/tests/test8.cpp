//int variable store and read from different memory section
int x;
int mema[5];
int main()
{
	
	int y;
	int z[30];
	y=3;println(y); // 3
	z[3] = 4; y=z[3]; println(y); // 4
	mema[3] = 5 ; y=mema[3]; println(y); // 5
	x=6;println(x); // 6
}