#include <bits/stdc++.h>
using namespace std;
#include "SymbolTable.h"

//#define DBG(x) cout<<(__LINE__)<<" : "<<(#x) <<" -> "<<(x)<<"\n";

int main()
{
    freopen("input.txt" , "r" , stdin);
    freopen("output.txt" , "w" , stdout);

    int n;
    cin>>n;

    
    

    char cmd;

    using valueType = string ;

    ScopeTable<valueType>::setTotalBucket(n);
    SymbolTable<valueType> * st = new SymbolTable<valueType>();

    while(cin>>cmd)
    {
        if(cmd == 'S')
        {
            cout<<cmd<<endl;
            st->enterScope();
        }
        else if(cmd == 'E')
        {
            cout<<cmd<<endl;
            st->exitScope();
        }
        else if(cmd == 'P')
        {
            char c;
            cin>>c;
            cout<<cmd<<" "<<c<<endl;
            if(c=='C')
                cout<<(*st->getCurrentScopeTable())<<endl;
            else cout<<(*st)<<endl;
        }
        else if(cmd == 'L')
        {
            string name ;
            cin>>name;
            cout<<cmd<<" "<<name<<endl;
            st->lookUp(name);
        }
        else if (cmd == 'I')
        {
            string name ;
            valueType type;
            cin>>name>>type;

            cout<<cmd<<" "<<name<<" "<<type<<endl;
            st->insert(name, type);
        }
        else if(cmd == 'D')
        {
            string name;
            cin>>name;

            cout<<cmd<<" "<<name<<endl;
            st->erase(name);
        }
        cout<<endl;
    }
    delete st;
    
    
}