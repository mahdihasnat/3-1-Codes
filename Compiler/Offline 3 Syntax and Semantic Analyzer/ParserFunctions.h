#ifndef ADDED_PARSERFUNCTIONS
#define ADDED_PARSERFUNCTIONS

extern int yylineno;
extern char * yytext;
extern int error_count;

extern ofstream logstream;
extern ofstream errorstream;

void yyerror(const char *s)
{
	error_count++;
	cout<<s<<"\n";
	errorstream<<s<<"\n";
}

void print(SymbolInfoPointer sip)
{
	logstream<<endl;
	while (sip)
	{
		logstream<<" "<< sip->getName();
		sip = sip->getNextSymbolInfo();
	}
	logstream<<endl;
	
	
}


#endif