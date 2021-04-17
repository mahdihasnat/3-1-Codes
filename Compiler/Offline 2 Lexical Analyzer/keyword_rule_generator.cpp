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
			cout<<"\n";
			cout<<"\t\t#ifdef LEXICAL_OUTPUT_ENABLED\n";
			cout<<"\t\t\tlogstream<<\"Line no \"<<yylineno<<\": Token <"<<token<<"> Lexeme \"<<yytext<<\" found\\n\";\n";
			cout<<"\t\t#endif\n";
			cout<<"\n";
			cout<<"\t\treturn "<<token<<";\n";
			cout<<"\t}\n";
		}
		else break;
	}
	
}