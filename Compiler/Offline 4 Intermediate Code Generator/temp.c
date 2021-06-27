int dp_bar[100];
int dp_foo[100];
int bar(int x,int y);
int foo(int x,int y)
{
    if(x == 0 || y == 0)
        return 1;
    if(dp_foo[x*10+y]!= -1)
        return dp_foo[x*10+y];
    dp_foo[x*10+y] = foo(x-1,y) + bar(x,y-1);
    return dp_foo[x*10+y];
}

int bar(int x,int y)
{
    if(x==0 || y ==0)
        return 1;
    if(dp_bar[x*10+y]!= -1)
        return dp_bar[x*10+y];
    dp_bar[x*10+y] = foo(x-1,y) + bar(x,y-1) + 1;
    return dp_bar[x*10+y];
}
#include<stdio.h>
int main(){
    int i,j;
    for(i=0;i<100;i++)
    {
        dp_bar[i]=-1;
        dp_foo[i]=-1;
    }

    int x ;
    x=foo(1,1);
	
    printf("%d",x);
}