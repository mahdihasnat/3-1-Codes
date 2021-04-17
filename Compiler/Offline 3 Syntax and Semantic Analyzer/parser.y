%{

#include<bits/stdc++.h>
using namespace std;

#include "SymbolInfo.h"
#include "SymbolTable.h"

#define YACC_OUTPUT_ENABLED 1

/// declared in scanner.l 
extern int yylineno;
extern char * yytext;
int yyparse(void);
int yylex(void);
void yylex_destroy();

int get_lineno(string text = yytext);
extern FILE *yyin;


/// declared in perser.y
SymbolTable<string> *symboltable;
ofstream logstream ;
ofstream errorstream;
int error_count = 0;

void yyerror(const char *s)
{
	cout<<s<<"\n";
	errorstream<<s<<"\n";
}



%}

%union {
		SymbolInfoChain<string> * SymbolInfoStringPointer;
		string * StringPointer;
	}


%token IF ELSE FOR WHILE DO 
%token SWITCH CASE DEFAULT CONTINUE BREAK
%token PRINTLN
%token RETURN
%token ASSIGNOP LOGICOP RELOP ADDOP MULOP NOT
%token INCOP DECOP
%token INT FLOAT VOID CHAR DOUBLE
%token <StringPointer> CONST_FLOAT
%token <StringPointer> CONST_INT
%token CONST_CHAR
%token LPAREN LCURL LTHIRD
%token RPAREN RCURL RTHIRD
%token SEMICOLON COMMA
%token <SymbolInfoStringPointer> ID

%token <StringPointer> STRING
 //%destructor { if($$) delete $$ ; } <StringPointer>

%%

start : program
	{
		//write your code in this block in all the similar blocks below
	}
	;

program : program unit 
	| unit
	;
	
unit : var_declaration
     | func_declaration
     | func_definition
     ;
     
func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
		| type_specifier ID LPAREN RPAREN SEMICOLON
		;
		 
func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement
		| type_specifier ID LPAREN RPAREN compound_statement
 		;				


parameter_list  : parameter_list COMMA type_specifier ID
		| parameter_list COMMA type_specifier
 		| type_specifier ID
		| type_specifier
 		;

 		
compound_statement : LCURL statements RCURL
 		    | LCURL RCURL
 		    ;
 		    
var_declaration : type_specifier declaration_list SEMICOLON
 		 ;
 		 
type_specifier	: INT
 		| FLOAT
 		| VOID
 		;
 		
declaration_list : declaration_list COMMA ID
 		  | declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
 		  | ID
 		  | ID LTHIRD CONST_INT RTHIRD
 		  ;
 		  
statements : statement
	   | statements statement
	   ;
	   
statement : var_declaration
	  | expression_statement
	  | compound_statement
	  | FOR LPAREN expression_statement expression_statement expression RPAREN statement
	  | IF LPAREN expression RPAREN statement
	  | IF LPAREN expression RPAREN statement ELSE statement
	  | WHILE LPAREN expression RPAREN statement
	  | PRINTLN LPAREN ID RPAREN SEMICOLON
	  | RETURN expression SEMICOLON
	  ;
	  
expression_statement 	: SEMICOLON			
			| expression SEMICOLON 
			;
	  
variable : ID 		
	 | ID LTHIRD expression RTHIRD 
	 ;
	 
expression : logic_expression	
	   | variable ASSIGNOP logic_expression 	
	   ;
			
logic_expression : rel_expression 	
		 | rel_expression LOGICOP rel_expression 	
		 ;
			
rel_expression	: simple_expression 
		| simple_expression RELOP simple_expression	
		;
				
simple_expression : term 
		  | simple_expression ADDOP term 
		  ;
					
term :	unary_expression
     |  term MULOP unary_expression
     ;

unary_expression : ADDOP unary_expression  
		 | NOT unary_expression 
		 | factor 
		 ;
	
factor	: variable 
	| ID LPAREN argument_list RPAREN
	| LPAREN expression RPAREN
	| CONST_INT 
	{	
		logstream<<"\nAt line no: "<<get_lineno()<<" factor : CONST_INT\n";
		logstream<<"\n"<< $1 <<endl;
	}
	| CONST_FLOAT
	{
		logstream<<"\nAt line no: "<<get_lineno()<<" factor : CONST_FLOAT\n";
		logstream<<"\n"<< $1 <<endl;
	}
	| variable INCOP 
	| variable DECOP
	;
	
argument_list : arguments
			  |
			  ;
	
arguments : arguments COMMA logic_expression
	      | logic_expression
	      ;
 

%%
int main(int argc,char *argv[])
{

	if(argc < 4 )
	{
		printf("Provide input.txt log.txt error.txt");
		exit(1);
	}

	FILE * fp , * fp2 , * fp3 ;

	fp=fopen(argv[1],"r");
	if( fp == NULL)
	{
		printf("Cannot Open Input File.\n");
		exit(1);
	}

	
	fp3= fopen(argv[3],"w");
	fclose(fp3);
	
	

	logstream.open(argv[2] , ios::out);
	errorstream.open(argv[3] , ios::out);
	
	

	ScopeTable<string>::setTotalBucket(7);
	symboltable = new SymbolTable<string>();

	yyin=fp;
	yyparse();
	
	yylex_destroy();

	fclose(fp);
	
	
	return 0;
}

