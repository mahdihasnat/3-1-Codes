%option noyywrap yylineno  
%{

#include "SymbolTable.h"

#include<bits/stdc++.h>
using namespace std;
#define DBG(x) cerr << (__LINE__) << " : " << (#x) << " -> " << (x) << "\n";

#define NL cout<<endl;

SymbolTable<string> * symboltable;

string COMMENT_BUFFER;
string STRING_BUFFER;

void printTokenAscii(char * s)
{
	while(*s)
		{
			cout<<(int)(*s)<<" ";
			s++;
		}
}

string get_row_char(string chs)
{
	if(chs == "\\n")
		chs = '\n';
	else if(chs == "\\a")
		chs = '\a';
	else if(chs == "\\f")
		chs = '\f';
	else if(chs == "\\r")
		chs = '\r';
	else if(chs == "\\b")
		chs = '\b';
	else if(chs == "\\v")
		chs = '\v';
	else if(chs == "\\0")
		chs = '\0';
	else if(chs == "\\t")
		chs = '\t';
	else if(chs == "\\\\")
		chs = '\\';
	else if(chs == "\\\'")
		chs = '\'';
	else if (chs == "\\\"")
		chs = '"';
	else if(chs.size() == 2 and chs[0] == '\\')
		chs = chs[1];

	// assert(chs.size() == 1);
	return chs;
}

string get_row_string(string s)
{
	/*
		backslash must followed by and chararcter
	*/
	string ret ="";
	for(int i=0;i<s.size();i++)
	{
		if(s[i] == '\\')
		{

			if(s[i+1] == '\n')
			{
				i++;
			}
			else if(i+2<s.size() and s[i+1] == '\r' and s[i+2] == '\n')
			{
				i+=2;
			}
			else 
			{
				ret+=get_row_char(s.substr(i,2));
				i++;
			}
		}
		else ret+=s[i];
	}
	return ret;
}

int get_lineno(string text = yytext)
{
	int ret =  yylineno;
	for(char c:text)
		ret-=c=='\n';
	return ret;
}

void processsToken(string token , string attr)
{
	cout<<"<"<<token;
	if(attr!="")
		cout<<", "<<attr;
	cout<<"> ";
}

int error_count = 0;

void processError(int line_number, string text, string reason)
{
	error_count++;
  	cerr<<"\nError at line no "<<line_number<<": "<<reason<<" "<<text<<"\n";
}

void insertSymbol(string key , string value)
{
	if(symboltable->insert(key , value))
		symboltable->printNonEmptyBuckets(cerr);
}

%}


	// to comment in this section : TAB\\ or TAB/*

%x BLOCK_COMMENT_STATE
%x STRING_STATE

NEWLINE \r?\n
CONTINUOUS_LINE \\{NEWLINE}
WHITE_SPACE [ \n\t\r]
WHITE_SPACES {WHITE_SPACE}+

LINE_COMMENT \/\/([^\r\n]|{CONTINUOUS_LINE})*
	// line comment = // anything except new line  + continous line\
						= anychar except \r + continous line

BLOCK_COMMENT_START "/*"
BLOCK_COMMENT_END "*/"

DIGIT [0-9]
CONST_INT [0-9]+
EXPONENT ((E|e)[+-]?{DIGIT}+)
CONST_FLOAT ((({DIGIT}+\.{DIGIT}*)|({DIGIT}*\.{DIGIT}+)){EXPONENT}?)|({DIGIT}+{EXPONENT})
	//float  = 3.14159, 3.14159E-10, .314159 and 314159E10
	// two case 
	//1.with decimal(either int part or float part  has digit) - exponent optional
	//2.without decimal - exponent must , base must

MULTIPLE_DECIMAL_ERROR [0-9]*\.[0-9]*(\.[0-9]*)+({EXPONENT}\.{DIGIT}*)*

NUMBERIC_IDENTIFIER_ERROR ({CONST_FLOAT}|{CONST_INT}){IDENTIFIER}

NUMBER_FORMAT_ERROR {CONST_FLOAT}(\.{DIGIT}*)*


SINGLE_CHAR_EXCEPT_SINGLE_QUOTE {CONTINUOUS_LINE}*([^'\n\\\r]|\\.){CONTINUOUS_LINE}*
	//1.any single char except ( escape , single quote , \n \r )
	//2. escape followed by anything
	
	//CONST_CHAR '(([ -~]{-}[\\'])|(\\[nt'afrbv0\\]))'
CONST_CHAR '{SINGLE_CHAR_EXCEPT_SINGLE_QUOTE}'
	//'\n','\t','\\','\'','\a','\f','\r','\b','\v'and'\0'
	// or 'a' , 'z'

ALPHANUMERIC_CHAR [a-zA-Z0-9]
ALPHABET_CHAR [a-zA-Z]
IDENTIFIER [a-zA-Z_]({ALPHANUMERIC_CHAR}|_)*

STRING_START \"
STRING_END \"

ADDOP [+\-]
	// + , - ADDOP
MULOP [*/%]
	//*, /, % MULOP
INCOP ("++")|("--")
	//++, - - INCOP
RELOP ([<>]=?)|([=!]=)
	//<, <=, >, >=, ==, != RELOP
LOGICOP "&&"|"||"
	//&&, || LOGICOP


MULTI_CHAR_ERROR '{SINGLE_CHAR_EXCEPT_SINGLE_QUOTE}{2,}'
	// single ' followed by anything except single ' followed by single '

UNTERMINATED_CHAR_ERROR '{SINGLE_CHAR_EXCEPT_SINGLE_QUOTE}*
	// single ' followed by enything except single ' or space newline
EMPTY_CHAR_ERROR '{CONTINUOUS_LINE}*'


%%

{NEWLINE}	{
				//cout<<"New Line paise";
				//printTokenAscii(yytext);
				//cout<<" \n";
				//NL;
			}
{WHITE_SPACES}	{
					//cout<<"white spaces\n";
				}
	
	/*{CONTINUOUS_LINE}	{
				cout<<"CONTINUOUS_LINE paise";
				//printTokenAscii(yytext);
				//cout<<" \n";
				NL;
			}
	*/
{LINE_COMMENT}	{
					
					cerr<<"\nLine no "<< get_lineno() <<": Token <COMMENT> Lexeme "<<yytext<<" found\n";
				}
{BLOCK_COMMENT_START}	{
							BEGIN BLOCK_COMMENT_STATE;
							COMMENT_BUFFER+=yytext;
					}
<BLOCK_COMMENT_STATE>{
	{BLOCK_COMMENT_END}	{
		COMMENT_BUFFER+=yytext;

		//yytext = COMMENT_BUFFER;
	  	cerr<<"\nLine no "<< get_lineno(COMMENT_BUFFER) <<": Token <COMMENT> Lexeme "<<COMMENT_BUFFER<<" found\n";

		COMMENT_BUFFER.clear();
		BEGIN INITIAL;
	}
	. COMMENT_BUFFER+=yytext;
	{WHITE_SPACES} COMMENT_BUFFER+=yytext;
	<<EOF>> {
				//yytext = COMMENT_BUFFER.c_str();
				processError( get_lineno(COMMENT_BUFFER)  ,COMMENT_BUFFER , "Unterminated Comment");

				COMMENT_BUFFER.clear();
				BEGIN INITIAL;
			}
}

{STRING_START} {
	BEGIN STRING_STATE;
	STRING_BUFFER+=yytext;
}
<STRING_STATE>{
	{STRING_END}	{
			STRING_BUFFER+=yytext;

			
			string row_symbol = get_row_string(STRING_BUFFER);
			
			processsToken("STRING" , STRING_BUFFER);

			cerr<<"\nLine no "<< get_lineno(STRING_BUFFER) <<": Token <STRING> Lexeme "<<STRING_BUFFER<<" found";
			cerr<<" --> <STRING, "<<row_symbol<<">\n";

			STRING_BUFFER.clear();
			BEGIN INITIAL;
		}
	{CONTINUOUS_LINE} STRING_BUFFER+=yytext;
	\\.	STRING_BUFFER+=yytext;
	. STRING_BUFFER+=yytext;

	<<EOF>> {
				processError( get_lineno(STRING_BUFFER)  ,STRING_BUFFER , "Unterminated String");
				STRING_BUFFER.clear();
				BEGIN INITIAL;
			}
	\n {
				STRING_BUFFER+=yytext;
				processError( get_lineno(STRING_BUFFER)  ,STRING_BUFFER , "Unterminated String");
				STRING_BUFFER.clear();
				BEGIN INITIAL;
			}
	
}
	


{CONST_INT}	{
		string symbol = string(yytext);
		processsToken("CONST_INT" , symbol);
		cerr<<"\nLine no "<< get_lineno() <<": Token <CONST_INT> Lexeme "<<symbol<<" found\n";
		insertSymbol(symbol ,"CONST_INT" );
	}
{CONST_FLOAT}	{
		string symbol = string(yytext);
		processsToken("CONST_FLOAT" ,symbol );
		cerr<<"\nLine no "<< get_lineno() <<": Token <CONST_FLOAT> Lexeme "<<symbol<<" found\n";
		insertSymbol(symbol ,"CONST_FLOAT" );
	}
{CONST_CHAR}	{
					string symbol = string(yytext);
					string ascii_symbol = symbol;
					if(ascii_symbol[0] == '\'')
						ascii_symbol = ascii_symbol.substr(1);
					if(ascii_symbol.back() == '\'')
						ascii_symbol.pop_back();

					/* '\n','\t','\\',
			'\'','\a','\f','\r','\b','\v'and'\0'. */
					
					ascii_symbol = get_row_char(ascii_symbol);

					processsToken("CONST_CHAR" , ascii_symbol);
					cerr<<"\nLine no "<< get_lineno() <<": Token <CONST_CHAR> Lexeme "<<symbol<<"found --> <CHAR_CONST, "<<ascii_symbol<<"> \n";
					insertSymbol(symbol ,"CONST_CHAR" );
				}

"if"    {
                processsToken("IF","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <IF> Lexeme "<<yytext<<" found\n";  
        }
"else"  {
                processsToken("ELSE","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <ELSE> Lexeme "<<yytext<<" found\n";
        }
"for"   {
                processsToken("FOR","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <FOR> Lexeme "<<yytext<<" found\n";
        }
"while" {
                processsToken("WHILE","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <WHILE> Lexeme "<<yytext<<" found\n";
        }
"do"    {
                processsToken("DO","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <DO> Lexeme "<<yytext<<" found\n";
        }
"break" {
                processsToken("BREAK","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <BREAK> Lexeme "<<yytext<<" found\n";
        }
"int"   {
                processsToken("INT","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <INT> Lexeme "<<yytext<<" found\n";
        }
"char"  {
                processsToken("CHAR","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <CHAR> Lexeme "<<yytext<<" found\n";
        }
"float" {
                processsToken("FLOAT","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <FLOAT> Lexeme "<<yytext<<" found\n";
        }
"double"        {
                processsToken("DOUBLE","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <DOUBLE> Lexeme "<<yytext<<" found\n";
        }
"void"  {
                processsToken("VOID","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <VOID> Lexeme "<<yytext<<" found\n";
        }
"return"        {
                processsToken("RETURN","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <RETURN> Lexeme "<<yytext<<" found\n";
        }
"switch"        {
                processsToken("SWITCH","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <SWITCH> Lexeme "<<yytext<<" found\n";
        }
"case"  {
                processsToken("CASE","");
                cerr<<"\nLine no "<< get_lineno() <<": Token <CASE> Lexeme "<<yytext<<" found\n";
        }
"default"       {
                processsToken("DEFAULT","");
                cerr<<"Line no "<<yylineno<<": Token <DEFAULT> Lexeme "<<yytext<<" found\n";
        }
"continue"      {
                processsToken("CONTINUE","");
                cerr<<"Line no "<<yylineno<<": Token <CONTINUE> Lexeme "<<yytext<<" found\n";
        }
"="     {
                processsToken("ASSIGNOP",string(yytext));
                cerr<<"\nLine no "<< get_lineno() <<": Token <ASSIGNOP> Lexeme "<<yytext<<" found\n";
        }
"!"     {
                processsToken("NOT",string(yytext));
                cerr<<"\nLine no "<< get_lineno() <<": Token <NOT> Lexeme "<<yytext<<" found\n";
        }
"("     {
                processsToken("LPAREN",string(yytext));
                cerr<<"\nLine no "<< get_lineno() <<": Token <LPAREN> Lexeme "<<yytext<<" found\n";
        }
")"     {
                processsToken("RPAREN",string(yytext));
                cerr<<"\nLine no "<< get_lineno() <<": Token <RPAREN> Lexeme "<<yytext<<" found\n";
        }
"{"     {
                processsToken("LCURL",string(yytext));
				symboltable->enterScope();
                cerr<<"\nLine no "<< get_lineno() <<": Token <LCURL> Lexeme "<<yytext<<" found\n";
        }
"}"     {
                processsToken("RCURL",string(yytext));
				symboltable->exitScope();
                cerr<<"\nLine no "<< get_lineno() <<": Token <RCURL> Lexeme "<<yytext<<" found\n";
        }
"["     {
                processsToken("LTHIRD",string(yytext));
                cerr<<"\nLine no "<< get_lineno() <<": Token <LTHIRD> Lexeme "<<yytext<<" found\n";
        }
"]"     {
                processsToken("RTHIRD",string(yytext));
                cerr<<"\nLine no "<< get_lineno() <<": Token <RTHIRD> Lexeme "<<yytext<<" found\n";
        }
","     {
                processsToken("COMMA",string(yytext));
                cerr<<"\nLine no "<< get_lineno() <<": Token <COMMA> Lexeme "<<yytext<<" found\n";
        }
";"     {
                processsToken("SEMICOLON",string(yytext));
                cerr<<"\nLine no "<< get_lineno() <<": Token <SEMICOLON> Lexeme "<<yytext<<" found\n";
        }
{LOGICOP}	{
				processsToken("LOGICOP",string(yytext));
                cerr<<"\nLine no "<< get_lineno() <<": Token <LOGICOP> Lexeme "<<yytext<<" found\n";
        }
{ADDOP}		{
				processsToken("ADDOP",string(yytext));
                cerr<<"\nLine no "<< get_lineno() <<": Token <ADDOP> Lexeme "<<yytext<<" found\n";
			}
{MULOP}		{
				processsToken("MULOP",string(yytext));
                cerr<<"\nLine no "<< get_lineno() <<": Token <MULOP> Lexeme "<<yytext<<" found\n";
			}
{INCOP}		{
				processsToken("INCOP",string(yytext));
                cerr<<"\nLine no "<< get_lineno() <<": Token <INCOP> Lexeme "<<yytext<<" found\n";
			}
{RELOP}		{
				processsToken("RELOP",string(yytext));
                cerr<<"\nLine no "<< get_lineno() <<": Token <RELOP> Lexeme "<<yytext<<" found\n";
			}


{IDENTIFIER}	{ 
					string symbol = string(yytext);
					processsToken("ID" , symbol);

					cerr<<"\nLine no "<< get_lineno() <<": Token <ID> Lexeme "<<symbol<<" found\n";
					insertSymbol(symbol , "ID");
					// if(symboltable->insert(symbl,"ID"))
					// 	symboltable->printNonEmpotyBuckets(cerr);
				}


{MULTIPLE_DECIMAL_ERROR}	{
								processError( get_lineno()  , yytext , "Too many decimal points");
							}
{NUMBERIC_IDENTIFIER_ERROR}		{
									processError( get_lineno()  , yytext , "Invalid prefix on ID or invalid suffix on Number");
								}
{NUMBER_FORMAT_ERROR}	{
							processError( get_lineno()  , yytext , "Ill formed number");
						}
{MULTI_CHAR_ERROR}	{
						processError( get_lineno()  , yytext , "Multi character constant error");
					}
{UNTERMINATED_CHAR_ERROR}	{
							processError( get_lineno()  , yytext , "Unterminated character");
						}	
{EMPTY_CHAR_ERROR}	{
						processError( get_lineno()  , yytext , "Empty character constant error");
					}
.	{
		processError( get_lineno()  , yytext , "Unrecognized character" );
	}
%%

int main(int argc,char *argv[]){
	
	if(argc<3){
		printf("Please provide input file name , log_file_name , [output_file_name optional] and try again\n");
		return 0;
	}
	
	FILE *fin=fopen(argv[1],"r");
	if(fin==NULL){
		printf("Cannot open specified file\n");
		return 0;
	}

	freopen(argv[2] , "w+" , stderr);
	if(3 < argc)
		freopen(argv[3] , "w+" , stdout);

	ScopeTable<string>::setTotalBucket(7);
	symboltable = new SymbolTable<string>();

	yylineno  = 1;
	yyin= fin;
	yylex();
	
	symboltable->printNonEmptyBuckets(cerr);
	cerr<<"Total lines: "<< yylineno <<"\n";
	cerr<<"Total errors: "<<error_count<<"\n";

	fclose(yyin);

	delete  symboltable;

	yylex_destroy();
	return 0;
}
