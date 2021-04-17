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
			else if (rhts.size() ) cout<<"\t| ";

			for(string s: rhts)
				cout<<" "<<s;
			if(rhts.size())
			{
				cout<<endl;
				cout<<"\t{\n";
				cout<<"\t\tlogstream<<\"At line no: \"<<get_lineno(\"\")<<\" "<<from<<" :";
				for(string s: rhts)
					cout<<" "<<s;

				cout<<"\";"<<endl;
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