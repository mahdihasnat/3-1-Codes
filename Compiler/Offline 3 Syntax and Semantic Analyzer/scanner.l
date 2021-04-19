
%option noyywrap yylineno 

%{


#include "SymbolTable.h"
#include "y.tab.h"

#include<bits/stdc++.h>
using namespace std;


/// define LEXICAL_OUTPUT_ENABLED 
/// to print lexical diagnostics to logsream 

//#define LEXICAL_OUTPUT_ENABLED

/// declared in parser.y

extern ofstream logstream;
extern ofstream errorstream;
extern YYSTYPE yylval;

extern int error_count;
void yyerror(char *);

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

SymbolInfoPointer processsToken(string token , string attr)
{
	#ifdef LEXICAL_OUTPUT_ENABLED
		cout<<"<"<<token;
		if(attr!="")
			cout<<", "<<attr;
		cout<<"> ";
	#endif
	if(attr == "")
		attr = yytext;
	return new SymbolInfo<Info> (attr , token);
}

void processError(int line_number, string text, string reason)
{
	error_count++;
  	errorstream<<"\nError at line no "<<line_number<<": "<<reason<<" "<<text<<"\n";
  	logstream<<"\nError at line no "<<line_number<<": "<<reason<<" "<<text<<"\n";
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
				
			}
{WHITE_SPACES}	{
					
				}
	
{LINE_COMMENT}	{
				
					#ifdef LEXICAL_OUTPUT_ENABLED
						logstream<<"\nLine no "<< yylineno <<": Token <COMMENT> Lexeme "<<yytext<<" found\n";
					#endif
				}
{BLOCK_COMMENT_START}	{
							BEGIN BLOCK_COMMENT_STATE;
							COMMENT_BUFFER+=yytext;
					}
<BLOCK_COMMENT_STATE>{
	{BLOCK_COMMENT_END}	{
		COMMENT_BUFFER+=yytext;

		//yytext = COMMENT_BUFFER;
		
		#ifdef LEXICAL_OUTPUT_ENABLED
	  		logstream<<"\nLine no "<<  yylineno <<": Token <COMMENT> Lexeme "<<COMMENT_BUFFER<<" found\n";
		#endif

		COMMENT_BUFFER.clear();
		BEGIN INITIAL;
	}
	. COMMENT_BUFFER+=yytext;
	{WHITE_SPACES} COMMENT_BUFFER+=yytext;
	<<EOF>> {
				
				processError(  yylineno  ,COMMENT_BUFFER , "Unterminated Comment");

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
			
			
			
			yylval.symbolInfoPointer = processsToken("STRING" , STRING_BUFFER);

			

			cerr<<"\nLine no "<<  yylineno <<": Token <STRING> Lexeme "<<STRING_BUFFER<<" found";
			cerr<<" --> <STRING, "<<row_symbol<<">\n";

			STRING_BUFFER.clear();
			BEGIN INITIAL;

			
			return STRING;
		}
	{CONTINUOUS_LINE} STRING_BUFFER+=yytext;
	\\.	STRING_BUFFER+=yytext;
	. STRING_BUFFER+=yytext;

	<<EOF>> {
				
				processError(  yylineno  ,STRING_BUFFER , "Unterminated String");

				STRING_BUFFER.clear();
				BEGIN INITIAL;
			}
	\n {
				STRING_BUFFER+=yytext;

				processError(  yylineno  ,STRING_BUFFER , "Unterminated String");
				
				STRING_BUFFER.clear();
				BEGIN INITIAL;
			}
	
}
	


{CONST_INT}	{
		string symbol = string(yytext);
		yylval.symbolInfoPointer = processsToken("CONST_INT" , symbol);
		
		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<< yylineno <<": Token <CONST_INT> Lexeme "<<symbol<<" found\n";
		#endif



		return CONST_INT;
	}
{CONST_FLOAT}	{
		string symbol = string(yytext);
		yylval.symbolInfoPointer = processsToken("CONST_FLOAT" ,symbol );

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<< yylineno <<": Token <CONST_FLOAT> Lexeme "<<symbol<<" found\n";
		#endif



		return CONST_FLOAT;
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

					yylval.symbolInfoPointer = processsToken("CONST_CHAR" , ascii_symbol);
					cerr<<"\nLine no "<< yylineno <<": Token <CONST_CHAR> Lexeme "<<symbol<<"found --> <CHAR_CONST, "<<ascii_symbol<<"> \n";
					
					

					return CONST_CHAR;
				}
"if"	{
		yylval.symbolInfoPointer = processsToken("IF","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <IF> Lexeme "<<yytext<<" found\n";
		#endif

		return IF;
	}
"else"	{
		yylval.symbolInfoPointer = processsToken("ELSE","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <ELSE> Lexeme "<<yytext<<" found\n";
		#endif

		return ELSE;
	}
"for"	{
		yylval.symbolInfoPointer = processsToken("FOR","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <FOR> Lexeme "<<yytext<<" found\n";
		#endif

		return FOR;
	}
"while"	{
		yylval.symbolInfoPointer = processsToken("WHILE","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <WHILE> Lexeme "<<yytext<<" found\n";
		#endif

		return WHILE;
	}
"do"	{
		yylval.symbolInfoPointer = processsToken("DO","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <DO> Lexeme "<<yytext<<" found\n";
		#endif

		return DO;
	}
"break"	{
		yylval.symbolInfoPointer = processsToken("BREAK","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <BREAK> Lexeme "<<yytext<<" found\n";
		#endif

		return BREAK;
	}
"int"	{
		yylval.symbolInfoPointer = processsToken("INT","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <INT> Lexeme "<<yytext<<" found\n";
		#endif

		return INT;
	}
"char"	{
		yylval.symbolInfoPointer = processsToken("CHAR","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <CHAR> Lexeme "<<yytext<<" found\n";
		#endif

		return CHAR;
	}
"float"	{
		yylval.symbolInfoPointer = processsToken("FLOAT","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <FLOAT> Lexeme "<<yytext<<" found\n";
		#endif

		return FLOAT;
	}
"double"	{
		yylval.symbolInfoPointer = processsToken("DOUBLE","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <DOUBLE> Lexeme "<<yytext<<" found\n";
		#endif

		return DOUBLE;
	}
"void"	{
		yylval.symbolInfoPointer = processsToken("VOID","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <VOID> Lexeme "<<yytext<<" found\n";
		#endif

		return VOID;
	}
"return"	{
		yylval.symbolInfoPointer = processsToken("RETURN","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <RETURN> Lexeme "<<yytext<<" found\n";
		#endif

		return RETURN;
	}
"switch"	{
		yylval.symbolInfoPointer = processsToken("SWITCH","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <SWITCH> Lexeme "<<yytext<<" found\n";
		#endif

		return SWITCH;
	}
"case"	{
		yylval.symbolInfoPointer = processsToken("CASE","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <CASE> Lexeme "<<yytext<<" found\n";
		#endif

		return CASE;
	}
"default"	{
		yylval.symbolInfoPointer = processsToken("DEFAULT","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <DEFAULT> Lexeme "<<yytext<<" found\n";
		#endif

		return DEFAULT;
	}
"continue"	{
		yylval.symbolInfoPointer = processsToken("CONTINUE","");

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <CONTINUE> Lexeme "<<yytext<<" found\n";
		#endif

		return CONTINUE;
	}
"="	{
		yylval.symbolInfoPointer = processsToken("ASSIGNOP",string(yytext));

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <ASSIGNOP> Lexeme "<<yytext<<" found\n";
		#endif

		return ASSIGNOP;
	}
"!"	{
		yylval.symbolInfoPointer = processsToken("NOT",string(yytext));

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <NOT> Lexeme "<<yytext<<" found\n";
		#endif

		return NOT;
	}
"("	{
		yylval.symbolInfoPointer = processsToken("LPAREN",string(yytext));

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <LPAREN> Lexeme "<<yytext<<" found\n";
		#endif

		return LPAREN;
	}
")"	{
		yylval.symbolInfoPointer = processsToken("RPAREN",string(yytext));

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <RPAREN> Lexeme "<<yytext<<" found\n";
		#endif

		return RPAREN;
	}
"["	{
		yylval.symbolInfoPointer = processsToken("LTHIRD",string(yytext));

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <LTHIRD> Lexeme "<<yytext<<" found\n";
		#endif

		return LTHIRD;
	}
"]"	{
		yylval.symbolInfoPointer = processsToken("RTHIRD",string(yytext));

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <RTHIRD> Lexeme "<<yytext<<" found\n";
		#endif

		return RTHIRD;
	}
","	{
		yylval.symbolInfoPointer = processsToken("COMMA",string(yytext));

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <COMMA> Lexeme "<<yytext<<" found\n";
		#endif

		return COMMA;
	}
";"	{
		yylval.symbolInfoPointer = processsToken("SEMICOLON",string(yytext));

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <SEMICOLON> Lexeme "<<yytext<<" found\n";
		#endif

		return SEMICOLON;
	}
"{"	{
		yylval.symbolInfoPointer = processsToken("LCURL",string(yytext));

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <LCURL> Lexeme "<<yytext<<" found\n";
		#endif


		return LCURL;
	}
"}"	{
		yylval.symbolInfoPointer = processsToken("RCURL",string(yytext));

		#ifdef LEXICAL_OUTPUT_ENABLED
			logstream<<"\nLine no "<<yylineno<<": Token <RCURL> Lexeme "<<yytext<<" found\n";
		#endif


		return RCURL;
	}

{LOGICOP}	{
				yylval.symbolInfoPointer = processsToken("LOGICOP",string(yytext));
				#ifdef LEXICAL_OUTPUT_ENABLED
                	logstream<<"\nLine no "<< yylineno <<": Token <LOGICOP> Lexeme "<<yytext<<" found\n";
				#endif

				

				return LOGICOP;
        }
{ADDOP}		{
				yylval.symbolInfoPointer = processsToken("ADDOP",string(yytext));

				#ifdef LEXICAL_OUTPUT_ENABLED
                	logstream<<"\nLine no "<< yylineno <<": Token <ADDOP> Lexeme "<<yytext<<" found\n";
				#endif
				

				return ADDOP;
			}
{MULOP}		{
				yylval.symbolInfoPointer = processsToken("MULOP",string(yytext));
				
				#ifdef LEXICAL_OUTPUT_ENABLED
                	logstream<<"\nLine no "<< yylineno <<": Token <MULOP> Lexeme "<<yytext<<" found\n";
				#endif



				return MULOP;
			}
{INCOP}		{
				yylval.symbolInfoPointer = processsToken("INCOP",string(yytext));
                
				#ifdef LEXICAL_OUTPUT_ENABLED
                	logstream<<"\nLine no "<< yylineno <<": Token <INCOP> Lexeme "<<yytext<<" found\n";
				#endif



				return INCOP;
			}
{RELOP}		{

				yylval.symbolInfoPointer = processsToken("RELOP",string(yytext));
                
				#ifdef LEXICAL_OUTPUT_ENABLED
                	logstream<<"\nLine no "<< yylineno <<": Token <RELOP> Lexeme "<<yytext<<" found\n";
				#endif



				return RELOP;
			}


{IDENTIFIER}	{ 
					string symbol = string(yytext);
					yylval.symbolInfoPointer = processsToken("ID" , symbol);

					#ifdef LEXICAL_OUTPUT_ENABLED
						cerr<<"\nLine no "<< yylineno <<": Token <ID> Lexeme "<<symbol<<" found\n";
					#endif
					



					return ID;
				}


{MULTIPLE_DECIMAL_ERROR}	{
								processError( yylineno  , yytext , "Too many decimal points");
							}
{NUMBERIC_IDENTIFIER_ERROR}		{
									processError( yylineno  , yytext , "Invalid prefix on ID or invalid suffix on Number");
								}
{NUMBER_FORMAT_ERROR}	{
							processError( yylineno  , yytext , "Ill formed number");
						}
{MULTI_CHAR_ERROR}	{
						processError( yylineno  , yytext , "Multi character constant error");
					}
{UNTERMINATED_CHAR_ERROR}	{
							processError( yylineno  , yytext , "Unterminated character");
						}	
{EMPTY_CHAR_ERROR}	{
						processError( yylineno  , yytext , "Empty character constant error");
					}
.	{
		processError( yylineno  , yytext , "Unrecognized character" );
	}
%%





