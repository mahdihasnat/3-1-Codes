#include<bits/stdc++.h>
using namespace std;

int main()
{
	freopen("grammer.txt","r",stdin);
	freopen("grammer_rule.txt","w",stdout);

	string from ;

	set<string > non_terminals;

	while(cin>>from)
	{
		
		non_terminals.insert(from);

		bool first_rule = 1;
		
		while (1)
		{
			
			string line ;
			getline(cin , line);

			vector<string > rhts;

			stringstream ss(line);
			string x;

			bool end_rule = 0;

			while (ss>>x)
			{
				if(x == ":")
					continue;
				else if(x == "|")
					continue ;
				else if(x == ";")
				{
					end_rule = 1;
					break ;
				}
				else rhts.push_back(x) , non_terminals.insert(x);

			}

			if(first_rule)
				cout<<endl<<from<<" : ";
			else if (rhts.size() or end_rule == false) cout<<"\t| ";

			for(string s: rhts){
				cout<<" "<<s;
				if(s=="LCURL")
						cout<<"{symboltable->enterScope();}";
				else if(s=="RCURL")
						cout<<"{symboltable->printNonEmptyBuckets(logstream); symboltable->exitScope();}";
			}
			if(rhts.size() or end_rule == false)
			{
				if(rhts.size() == 5 and rhts.front() == "IF")
					cout<<" %prec SINGLE_IF";

				cout<<endl;
				cout<<"\t{\n";
				cout<<"\t\tlogstream<<\"\\nAt line no: \"<<yylineno<<\" "<<from<<" :";
				for(string s: rhts){
					cout<<" "<<s;
				}
				
				cout<<"\"<<endl;"<<endl;

				if(rhts.size())
				{
					for(int i=1;i<rhts.size();i++)
						cout<<"\t\t$"<<i<<" -> push_back( $"<<i+1<<" );\n";
					cout<<"\t\t$$ = $1;\n";
				}
				else cout<<"\t\t$$=nullptr;\n";

				cout<<"\t\tprint($$);\n";

				if(from == "start" )
					cout<<"\t\tdelete $$;\n";

				cout<<"\t}";
				cout<<endl;
			}



			if(end_rule) 
			{
				cout<<"\t;\n";
				break;
			}



			first_rule = 0;
			
		}
		


	}

	for(string s: non_terminals)
		cout<<"%type <symbolInfoPointer> "<<s<<"\n";

}