

int foo()
{
    int x;
    {
        int y;
        float z;
        int t[10];
        {
            if(1)
                return 2;
            
        }
    }
}

int main(){
    foo();
}
