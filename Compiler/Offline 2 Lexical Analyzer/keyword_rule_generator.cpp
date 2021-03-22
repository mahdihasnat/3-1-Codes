#include<bits/stdc++.h>
using namespace std;

int main()
{
	freopen("keywords.txt" , "r+", stdin);
	while (1)
	{
		string pattern , token;
		if(cin>>pattern)
		{
			cin>>token;
			cout<<"\""<<pattern<<"\"\t{\n\t\tprocesssToken(\""<<token<<"\",";
			if(token.size() != pattern.size())
				cout<<"string(yytext));\n";
			else 
				cout<<"\"\");\n";
			cout<<"\t\tcerr<<\"Line no \"<<yylineno<<\": Token <"<<token<<"> Lexeme \"<<yytext<<\" found\\n\";\n\t}\n";
		}
		else break;
	}
	
}