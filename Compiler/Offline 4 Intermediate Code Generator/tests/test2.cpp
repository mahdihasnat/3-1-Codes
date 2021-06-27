// double dependent recursive function 
int bar(int x,int y);
int foo(int x,int y)
{
    if(x == 0 || y == 0)
        return 1;
    else return foo(x-1,y) + bar(x,y-1);
}

int bar(int x,int y)
{
    if(x==0 || y ==0)
        return 1;
    else return foo(x-1,y) + bar(x,y-1) + 1;
}

int main(){
    int x ;
    x=foo(1,1);
    println(x);//2
}