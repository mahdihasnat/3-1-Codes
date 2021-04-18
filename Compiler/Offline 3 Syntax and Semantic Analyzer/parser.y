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

void insertSymbol(string key , string value)
{
	if(symboltable){
	if(symboltable->insert(key , value))
		symboltable->printNonEmptyBuckets(logstream);
	}
	else 
	{
		errorstream<<"file : "<< __FILE__<<" line: "<<__LINE__<<" Symboltable not found";
		assert(0);
	}
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

%nonassoc SINGLE_IF
%nonassoc ELSE


%%

start :  program
	{
		logstream<<"\nAt line no: "<<yylineno<<" start : program"<<endl;
	}
	;

program :  program unit
	{
		logstream<<"\nAt line no: "<<yylineno<<" program : program unit"<<endl;
	}
	|  unit
	{
		logstream<<"\nAt line no: "<<yylineno<<" program : unit"<<endl;
	}
	;

unit :  var_declaration
	{
		logstream<<"\nAt line no: "<<yylineno<<" unit : var_declaration"<<endl;
	}
	|  func_declaration
	{
		logstream<<"\nAt line no: "<<yylineno<<" unit : func_declaration"<<endl;
	}
	|  func_definition
	{
		logstream<<"\nAt line no: "<<yylineno<<" unit : func_definition"<<endl;
	}
	;

func_declaration :  type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON"<<endl;
	}
	|  type_specifier ID LPAREN RPAREN SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON"<<endl;
	}
	;

func_definition :  type_specifier ID LPAREN parameter_list RPAREN compound_statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement"<<endl;
	}
	|  type_specifier ID LPAREN RPAREN compound_statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" func_definition : type_specifier ID LPAREN RPAREN compound_statement"<<endl;
	}
	;

parameter_list :  parameter_list COMMA type_specifier ID
	{
		logstream<<"\nAt line no: "<<yylineno<<" parameter_list : parameter_list COMMA type_specifier ID"<<endl;
	}
	|  parameter_list COMMA type_specifier
	{
		logstream<<"\nAt line no: "<<yylineno<<" parameter_list : parameter_list COMMA type_specifier"<<endl;
	}
	|  type_specifier ID
	{
		logstream<<"\nAt line no: "<<yylineno<<" parameter_list : type_specifier ID"<<endl;
	}
	|  type_specifier
	{
		logstream<<"\nAt line no: "<<yylineno<<" parameter_list : type_specifier"<<endl;
	}
	;

compound_statement :  LCURL statements RCURL
	{
		logstream<<"\nAt line no: "<<yylineno<<" compound_statement : LCURL statements RCURL"<<endl;
	}
	|  LCURL RCURL
	{
		logstream<<"\nAt line no: "<<yylineno<<" compound_statement : LCURL RCURL"<<endl;
	}
	;

var_declaration :  type_specifier declaration_list SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" var_declaration : type_specifier declaration_list SEMICOLON"<<endl;
	}
	;

type_specifier :  INT
	{
		logstream<<"\nAt line no: "<<yylineno<<" type_specifier : INT"<<endl;
	}
	|  FLOAT
	{
		logstream<<"\nAt line no: "<<yylineno<<" type_specifier : FLOAT"<<endl;
	}
	|  VOID
	{
		logstream<<"\nAt line no: "<<yylineno<<" type_specifier : VOID"<<endl;
	}
	;

declaration_list :  declaration_list COMMA ID
	{
		logstream<<"\nAt line no: "<<yylineno<<" declaration_list : declaration_list COMMA ID"<<endl;
	}
	|  declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
	{
		logstream<<"\nAt line no: "<<yylineno<<" declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD"<<endl;
	}
	|  ID
	{
		logstream<<"\nAt line no: "<<yylineno<<" declaration_list : ID"<<endl;
	}
	|  ID LTHIRD CONST_INT RTHIRD
	{
		logstream<<"\nAt line no: "<<yylineno<<" declaration_list : ID LTHIRD CONST_INT RTHIRD"<<endl;
	}
	;

statements :  statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" statements : statement"<<endl;
	}
	|  statements statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" statements : statements statement"<<endl;
	}
	;

statement :  var_declaration
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : var_declaration"<<endl;
	}
	|  expression_statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : expression_statement"<<endl;
	}
	|  compound_statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : compound_statement"<<endl;
	}
	|  FOR LPAREN expression_statement expression_statement expression RPAREN statement
	{
		logstream <<"\nAt line no: "<<yylineno<<" statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement"<<endl;
	}
	|  IF LPAREN expression RPAREN statement %prec SINGLE_IF
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : IF LPAREN expression RPAREN statement"<<endl;
	}
	|  IF LPAREN expression RPAREN statement ELSE statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : IF LPAREN expression RPAREN statement ELSE statement"<<endl;
	}
	|  WHILE LPAREN expression RPAREN statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : WHILE LPAREN expression RPAREN statement"<<endl;
	}
	|  PRINTLN LPAREN ID RPAREN SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : PRINTLN LPAREN ID RPAREN SEMICOLON"<<endl;
	}
	|  RETURN expression SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : RETURN expression SEMICOLON"<<endl;
	}
	;

expression_statement :  SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" expression_statement : SEMICOLON"<<endl;
	}
	|  expression SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" expression_statement : expression SEMICOLON"<<endl;
	}
	;

variable :  ID
	{
		logstream<<"\nAt line no: "<<yylineno<<" variable : ID"<<endl;
	}
	|  ID LTHIRD expression RTHIRD
	{
		logstream<<"\nAt line no: "<<yylineno<<" variable : ID LTHIRD expression RTHIRD"<<endl;
	}
	;

expression :  logic_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" expression : logic_expression"<<endl;
	}
	|  variable ASSIGNOP logic_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" expression : variable ASSIGNOP logic_expression"<<endl;
	}
	;

logic_expression :  rel_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" logic_expression : rel_expression"<<endl;
	}
	|  rel_expression LOGICOP rel_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" logic_expression : rel_expression LOGICOP rel_expression"<<endl;
	}
	;

rel_expression :  simple_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" rel_expression : simple_expression"<<endl;
	}
	|  simple_expression RELOP simple_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" rel_expression : simple_expression RELOP simple_expression"<<endl;
	}
	;

simple_expression :  term
	{
		logstream<<"\nAt line no: "<<yylineno<<" simple_expression : term"<<endl;
	}
	|  simple_expression ADDOP term
	{
		logstream<<"\nAt line no: "<<yylineno<<" simple_expression : simple_expression ADDOP term"<<endl;
	}
	;

term :  unary_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" term : unary_expression"<<endl;
	}
	|  term MULOP unary_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" term : term MULOP unary_expression"<<endl;
	}
	;

unary_expression :  ADDOP unary_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" unary_expression : ADDOP unary_expression"<<endl;
	}
	|  NOT unary_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" unary_expression : NOT unary_expression"<<endl;
	}
	|  factor
	{
		logstream<<"\nAt line no: "<<yylineno<<" unary_expression : factor"<<endl;
	}
	;

factor :  variable
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : variable"<<endl;
	}
	|  ID LPAREN argument_list RPAREN
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : ID LPAREN argument_list RPAREN"<<endl;
	}
	|  LPAREN expression RPAREN
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : LPAREN expression RPAREN"<<endl;
	}
	|  CONST_INT
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : CONST_INT"<<endl;
	}
	|  CONST_FLOAT
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : CONST_FLOAT"<<endl;
	}
	|  variable INCOP
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : variable INCOP"<<endl;
	}
	|  variable DECOP
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : variable DECOP"<<endl;
	}
	;

argument_list :  arguments
	{
		logstream<<"\nAt line no: "<<yylineno<<" argument_list : arguments"<<endl;
	}
	| 
	{
		logstream<<"\nAt line no: "<<yylineno<<" argument_list :"<<endl;
	}
	;

arguments :  arguments COMMA logic_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" arguments : arguments COMMA logic_expression"<<endl;
	}
	|  logic_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" arguments : logic_expression"<<endl;
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

	delete symboltable;

	errorstream<<"\nTotal Errors: "<<error_count<<endl;

	fclose(fp);
	
	
	return 0;
}

