#include <bits/stdc++.h>
using namespace std;
int x;
int &foo()
{
	cout<<"foo\n";
	return  x;
}
int bar()
{
	cout<<"bar\n";
	return 10;
}
int main()
{
	foo()=bar();

}