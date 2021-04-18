#include<bits/stdc++.h>
using namespace std;

int main()
{
	freopen("grammer.txt","r",stdin);
	freopen("grammer_rule.txt","w",stdout);

	string from ;

	while(cin>>from)
	{

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
				else rhts.push_back(x);

			}

			if(first_rule)
				cout<<endl<<from<<" : ";
			else if (rhts.size() or end_rule == false) cout<<"\t| ";

			for(string s: rhts)
				cout<<" "<<s;
			if(rhts.size() or end_rule == false)
			{
				if(rhts.size() == 5 and rhts.front() == "IF")
					cout<<" %prec SINGLE_IF";

				cout<<endl;
				cout<<"\t{\n";
				cout<<"\t\tlogstream<<\"\\nAt line no: \"<<yylineno<<\" "<<from<<" :";
				for(string s: rhts)
					cout<<" "<<s;
				
				cout<<"\"<<endl;"<<endl;
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

}