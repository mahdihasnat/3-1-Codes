// global array , global variable , local variable ,
// parameter passing ,return
int x;
int dp[100];
int mema[100];
void fun()
{

}
void foo(int x,int y)
{
}
int bar()
{
	return dp[10];
}

int main()
{
	fun();
	x=10;
	mema[5]=34;
	foo(x,mema[5]);
	dp[10] = 199;
	x = bar();
	println(x); // 199
}