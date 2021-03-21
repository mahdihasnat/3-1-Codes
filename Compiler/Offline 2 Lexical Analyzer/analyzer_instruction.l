%option noyywrap yylineno 
%{

#include "symboltable.h"

#include<bits/stdc++.h>
using namespace std;
#define DBG(x) cerr << (__LINE__) << " : " << (#x) << " -> " << (x) << "\n";

#define NL cout<<endl;

SymbolTable<string> * symboltable;

void printTokenAscii(char * s)
{
	while(*s)
		{
			cout<<(int)(*s)<<" ";
			s++;
		}
}

%}
	// to comment in this section : TAB\\ or TAB/*

NEWLINE \r?\n
CONTINUOUS_LINE \\{NEWLINE}
WHITE_SPACE [ \n\t\r]
WHITE_SPACES {WHITE_SPACE}+

LINE_COMMENT \/\/([^\r]|{CONTINUOUS_LINE})*
	// line comment = // anything except new line  + continous line\
						= anychar except \r + continous line
BLOCK_COMMENT "/*"([^*]|("*"[^//]))*"*/"
	//block comment = /* ( anything except */  \
						=  anything except * at begining +\
						 anything with * at begining \
						 followed by anythinh except / )  */
CONST_INT [0-9]+
CONST_FLOAT [0-9]*(\.[0-9]+)?(E[+-]?[0-9]+)?
	//float  = 3.14159, 3.14159E-10, .314159 and 314159E10

ALPHANUMERIC_CHAR [a-zA-Z0-9]
ALPHABET_CHAR [a-zA-Z]
IDENTIFIER [a-zA-Z_](ALPHANUMERIC_CHAR|_)*

STRING (\"([^"\n\r]|\\\"|{CONTINUOUS_LINE})*[^"\\\n\r]+\")|(\"\")
	// can't contain \r\n anywhere except continuous line
	// can't  end with \" 
	// can't contain single "
	// can contain continuous line
%%

{WHITE_SPACES}	{
					//cout<<"white spaces\n";
				}

	/*{NEWLINE}	{
				cout<<"New Line paise";
				//printTokenAscii(yytext);
				//cout<<" \n";
				NL;
			}
	*/
	/*{CONTINUOUS_LINE}	{
				cout<<"CONTINUOUS_LINE paise";
				//printTokenAscii(yytext);
				//cout<<" \n";
				NL;
			}
	*/
{LINE_COMMENT}	{
					
					cerr<<"Line no "<<yylineno<<": Token <COMMENT> Lexeme "<<yytext<<" found\n";
				}
{BLOCK_COMMENT}	{
					cerr<<"Line no "<<yylineno<<": Token <COMMENT> Lexeme "<<yytext<<" found\n";;
				}

{CONST_INT}	{
		cout<<"<CONST_INT, "<<yytext<<">";
		cerr<<"Line no "<<yylineno<<": Token <CONST_INT> Lexeme "<<yytext<<" found\n";
	}

{CONST_FLOAT}	{
		cout<<"<CONST_FLOAT, "<<yytext<<">";
		cerr<<"Line no "<<yylineno<<": Token <CONST_FLOAT> Lexeme "<<yytext<<" found\n";
	}

"if"    {
                cout<<"<IF>";
                cerr<<"Line no "<<yylineno<<": Token <IF> Lexeme "<<yytext<<" found\n";
        }
"else"  {
                cout<<"<ELSE>";
                cerr<<"Line no "<<yylineno<<": Token <ELSE> Lexeme "<<yytext<<" found\n";
        }
"for"   {
                cout<<"<FOR>";
                cerr<<"Line no "<<yylineno<<": Token <FOR> Lexeme "<<yytext<<" found\n";
        }
"while" {
                cout<<"<WHILE>";
                cerr<<"Line no "<<yylineno<<": Token <WHILE> Lexeme "<<yytext<<" found\n";
        }
"do"    {
                cout<<"<DO>";
                cerr<<"Line no "<<yylineno<<": Token <DO> Lexeme "<<yytext<<" found\n";
        }
"break" {
                cout<<"<BREAK>";
                cerr<<"Line no "<<yylineno<<": Token <BREAK> Lexeme "<<yytext<<" found\n";
        }
"int"   {
                cout<<"<INT>";
                cerr<<"Line no "<<yylineno<<": Token <INT> Lexeme "<<yytext<<" found\n";
        }
"char"  {
                cout<<"<CHAR>";
                cerr<<"Line no "<<yylineno<<": Token <CHAR> Lexeme "<<yytext<<" found\n";
        }
"float" {
                cout<<"<FLOAT>";
                cerr<<"Line no "<<yylineno<<": Token <FLOAT> Lexeme "<<yytext<<" found\n";
        }
"double"        {
                cout<<"<DOUBLE>";
                cerr<<"Line no "<<yylineno<<": Token <DOUBLE> Lexeme "<<yytext<<" found\n";
        }
"void"  {
                cout<<"<VOID>";
                cerr<<"Line no "<<yylineno<<": Token <VOID> Lexeme "<<yytext<<" found\n";
        }
"return"        {
                cout<<"<RETURN>";
                cerr<<"Line no "<<yylineno<<": Token <RETURN> Lexeme "<<yytext<<" found\n";
        }
"switch"        {
                cout<<"<SWITCH>";
                cerr<<"Line no "<<yylineno<<": Token <SWITCH> Lexeme "<<yytext<<" found\n";
        }
"case"  {
                cout<<"<CASE>";
                cerr<<"Line no "<<yylineno<<": Token <CASE> Lexeme "<<yytext<<" found\n";
        }

{IDENTIFIER}	{ 
					string symbol = string(yytext);
					cout<<"<ID, "<<symbol<<">";

					cerr<<"Line no "<<yylineno<<": Token <ID> Lexeme "<<symbol<<" found\n";
					if(symboltable->insert(symbol,"ID"))
						symboltable->printNonEmptyBuckets(cerr);
				}

{STRING}	{ 
					//cerr<<yytext<<"\n";
					string symbol = string(yytext);
					cout<<"<STRING, "<<symbol<<">";

					cerr<<"Line no "<<yylineno<<": Token <STRING> Lexeme "<<symbol<<" found\n";
					if(symboltable->insert(symbol,"STRING"))
						symboltable->printNonEmptyBuckets(cerr);
				}

.	{ 
		//DBG(yytext);
	}
%%

int main(int argc,char *argv[]){
	
	if(argc!=2){
		printf("Please provide input file name and try again\n");
		return 0;
	}
	
	FILE *fin=fopen(argv[1],"r");
	if(fin==NULL){
		printf("Cannot open specified file\n");
		return 0;
	}

	freopen("log.txt" , "w+" , stderr);

	ScopeTable<string>::setTotalBucket(7);
	symboltable = new SymbolTable<string>();

	yylineno = 1;
	yyin= fin;
	yylex();
	fclose(yyin);
	return 0;
}
