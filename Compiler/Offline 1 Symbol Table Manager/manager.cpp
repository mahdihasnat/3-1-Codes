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

    ScopeTable::setTotalBucket(n);

    char cmd;

    SymbolTable * st = new SymbolTable();

    while(cin>>cmd)
    {
        if(cmd == 'S')
            st->enterScope();
        else if(cmd == 'E')
            st->exitScope();
        else if(cmd == 'P')
        {
            char c;
            cin>>c;
            if(c=='C')
                cout<<(*st->getCurrentScopeTable())<<endl;
            else cout<<(*st)<<endl;
        }
        else if(cmd == 'L')
        {
            string name ;
            cin>>name;
            st->lookUp(name);
        }
        else if (cmd == 'I')
        {
            string name , type;
            cin>>name>>type;
            st->insert(name, type);
        }
        else if(cmd == 'D')
        {
            string name;
            cin>>name;
            st->erase(name);
        }
        cout<<endl;
    }

}