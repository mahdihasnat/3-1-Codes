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


start :  program
	{
		logstream<<"At line no: "<<get_lineno("")<<" start : program";
	}
	;

program :  program unit
	{
		logstream<<"At line no: "<<get_lineno("")<<" program : program unit";
	}
	|  unit
	{
		logstream<<"At line no: "<<get_lineno("")<<" program : unit";
	}
	;

unit :  var_declaration
	{
		logstream<<"At line no: "<<get_lineno("")<<" unit : var_declaration";
	}
	|  func_declaration
	{
		logstream<<"At line no: "<<get_lineno("")<<" unit : func_declaration";
	}
	|  func_definition
	{
		logstream<<"At line no: "<<get_lineno("")<<" unit : func_definition";
	}
	;

func_declaration :  type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
	{
		logstream<<"At line no: "<<get_lineno("")<<" func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON";
	}
	|  type_specifier ID LPAREN RPAREN SEMICOLON
	{
		logstream<<"At line no: "<<get_lineno("")<<" func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON";
	}
	;

func_definition :  type_specifier ID LPAREN parameter_list RPAREN compound_statement
	{
		logstream<<"At line no: "<<get_lineno("")<<" func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement";
	}
	|  type_specifier ID LPAREN RPAREN compound_statement
	{
		logstream<<"At line no: "<<get_lineno("")<<" func_definition : type_specifier ID LPAREN RPAREN compound_statement";
	}
	;

parameter_list :  parameter_list COMMA type_specifier ID
	{
		logstream<<"At line no: "<<get_lineno("")<<" parameter_list : parameter_list COMMA type_specifier ID";
	}
	|  parameter_list COMMA type_specifier
	{
		logstream<<"At line no: "<<get_lineno("")<<" parameter_list : parameter_list COMMA type_specifier";
	}
	|  type_specifier ID
	{
		logstream<<"At line no: "<<get_lineno("")<<" parameter_list : type_specifier ID";
	}
	|  type_specifier
	{
		logstream<<"At line no: "<<get_lineno("")<<" parameter_list : type_specifier";
	}
	;

compound_statement :  LCURL statements RCURL
	{
		logstream<<"At line no: "<<get_lineno("")<<" compound_statement : LCURL statements RCURL";
	}
	|  LCURL RCURL
	{
		logstream<<"At line no: "<<get_lineno("")<<" compound_statement : LCURL RCURL";
	}
	;

var_declaration :  type_specifier declaration_list SEMICOLON
	{
		logstream<<"At line no: "<<get_lineno("")<<" var_declaration : type_specifier declaration_list SEMICOLON";
	}
	;

type_specifier :  INT
	{
		logstream<<"At line no: "<<get_lineno("")<<" type_specifier : INT";
	}
	|  FLOAT
	{
		logstream<<"At line no: "<<get_lineno("")<<" type_specifier : FLOAT";
	}
	|  VOID
	{
		logstream<<"At line no: "<<get_lineno("")<<" type_specifier : VOID";
	}
	;

declaration_list :  declaration_list COMMA ID
	{
		logstream<<"At line no: "<<get_lineno("")<<" declaration_list : declaration_list COMMA ID";
	}
	|  declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
	{
		logstream<<"At line no: "<<get_lineno("")<<" declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD";
	}
	|  ID
	{
		logstream<<"At line no: "<<get_lineno("")<<" declaration_list : ID";
	}
	|  ID LTHIRD CONST_INT RTHIRD
	{
		logstream<<"At line no: "<<get_lineno("")<<" declaration_list : ID LTHIRD CONST_INT RTHIRD";
	}
	;

statements :  statement
	{
		logstream<<"At line no: "<<get_lineno("")<<" statements : statement";
	}
	|  statements statement
	{
		logstream<<"At line no: "<<get_lineno("")<<" statements : statements statement";
	}
	;

statement :  var_declaration
	{
		logstream<<"At line no: "<<get_lineno("")<<" statement : var_declaration";
	}
	|  expression_statement
	{
		logstream<<"At line no: "<<get_lineno("")<<" statement : expression_statement";
	}
	|  compound_statement
	{
		logstream<<"At line no: "<<get_lineno("")<<" statement : compound_statement";
	}
	|  FOR LPAREN expression_statement expression_statement expression RPAREN statement
	{
		logstream<<"At line no: "<<get_lineno("")<<" statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement";
	}
	|  IF LPAREN expression RPAREN statement
	{
		logstream<<"At line no: "<<get_lineno("")<<" statement : IF LPAREN expression RPAREN statement";
	}
	|  IF LPAREN expression RPAREN statement ELSE statement
	{
		logstream<<"At line no: "<<get_lineno("")<<" statement : IF LPAREN expression RPAREN statement ELSE statement";
	}
	|  WHILE LPAREN expression RPAREN statement
	{
		logstream<<"At line no: "<<get_lineno("")<<" statement : WHILE LPAREN expression RPAREN statement";
	}
	|  PRINTLN LPAREN ID RPAREN SEMICOLON
	{
		logstream<<"At line no: "<<get_lineno("")<<" statement : PRINTLN LPAREN ID RPAREN SEMICOLON";
	}
	|  RETURN expression SEMICOLON
	{
		logstream<<"At line no: "<<get_lineno("")<<" statement : RETURN expression SEMICOLON";
	}
	;

expression_statement :  SEMICOLON
	{
		logstream<<"At line no: "<<get_lineno("")<<" expression_statement : SEMICOLON";
	}
	|  expression SEMICOLON
	{
		logstream<<"At line no: "<<get_lineno("")<<" expression_statement : expression SEMICOLON";
	}
	;

variable :  ID
	{
		logstream<<"At line no: "<<get_lineno("")<<" variable : ID";
	}
	|  ID LTHIRD expression RTHIRD
	{
		logstream<<"At line no: "<<get_lineno("")<<" variable : ID LTHIRD expression RTHIRD";
	}
	;

expression :  logic_expression
	{
		logstream<<"At line no: "<<get_lineno("")<<" expression : logic_expression";
	}
	|  variable ASSIGNOP logic_expression
	{
		logstream<<"At line no: "<<get_lineno("")<<" expression : variable ASSIGNOP logic_expression";
	}
	;

logic_expression :  rel_expression
	{
		logstream<<"At line no: "<<get_lineno("")<<" logic_expression : rel_expression";
	}
	|  rel_expression LOGICOP rel_expression
	{
		logstream<<"At line no: "<<get_lineno("")<<" logic_expression : rel_expression LOGICOP rel_expression";
	}
	;

rel_expression :  simple_expression
	{
		logstream<<"At line no: "<<get_lineno("")<<" rel_expression : simple_expression";
	}
	|  simple_expression RELOP simple_expression
	{
		logstream<<"At line no: "<<get_lineno("")<<" rel_expression : simple_expression RELOP simple_expression";
	}
	;

simple_expression :  term
	{
		logstream<<"At line no: "<<get_lineno("")<<" simple_expression : term";
	}
	|  simple_expression ADDOP term
	{
		logstream<<"At line no: "<<get_lineno("")<<" simple_expression : simple_expression ADDOP term";
	}
	;

term :  unary_expression
	{
		logstream<<"At line no: "<<get_lineno("")<<" term : unary_expression";
	}
	|  term MULOP unary_expression
	{
		logstream<<"At line no: "<<get_lineno("")<<" term : term MULOP unary_expression";
	}
	;

unary_expression :  ADDOP unary_expression
	{
		logstream<<"At line no: "<<get_lineno("")<<" unary_expression : ADDOP unary_expression";
	}
	|  NOT unary_expression
	{
		logstream<<"At line no: "<<get_lineno("")<<" unary_expression : NOT unary_expression";
	}
	|  factor
	{
		logstream<<"At line no: "<<get_lineno("")<<" unary_expression : factor";
	}
	;

factor :  variable
	{
		logstream<<"At line no: "<<get_lineno("")<<" factor : variable";
	}
	|  ID LPAREN argument_list RPAREN
	{
		logstream<<"At line no: "<<get_lineno("")<<" factor : ID LPAREN argument_list RPAREN";
	}
	|  LPAREN expression RPAREN
	{
		logstream<<"At line no: "<<get_lineno("")<<" factor : LPAREN expression RPAREN";
	}
	|  CONST_INT
	{
		logstream<<"At line no: "<<get_lineno("")<<" factor : CONST_INT";
	}
	|  CONST_FLOAT
	{
		logstream<<"At line no: "<<get_lineno("")<<" factor : CONST_FLOAT";
	}
	|  variable INCOP
	{
		logstream<<"At line no: "<<get_lineno("")<<" factor : variable INCOP";
	}
	|  variable DECOP
	{
		logstream<<"At line no: "<<get_lineno("")<<" factor : variable DECOP";
	}
	;

argument_list :  arguments
	{
		logstream<<"At line no: "<<get_lineno("")<<" argument_list : arguments";
	}
	|
	{
		logstream<<"At line no: "<<get_lineno("")<<" argument_list : empty";
	}
	
	;

arguments :  arguments COMMA logic_expression
	{
		logstream<<"At line no: "<<get_lineno("")<<" arguments : arguments COMMA logic_expression";
	}
	|  logic_expression
	{
		logstream<<"At line no: "<<get_lineno("")<<" arguments : logic_expression";
	}
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

	errorstream<<"\nTotal Errors: "<<error_count<<endl;

	fclose(fp);
	
	
	return 0;
}

