%{

#include<bits/stdc++.h>
using namespace std;

#include "SymbolInfo.h"
#include "SymbolTable.h"

#include "ParserFunctions.h"

#include "Info.h"

/// declared in scanner.l 

int yyparse(void);
int yylex(void);
void yylex_destroy();
extern FILE *yyin;


/// declared in perser.y

SymbolTable<Info> *symboltable;
ofstream logstream ;
ofstream errorstream;
int error_count = 0;


%}

%union {
		SymbolInfoPointer symbolInfoPointer;
	}


%token <symbolInfoPointer> IF ELSE FOR WHILE  
%token <symbolInfoPointer> DO SWITCH CASE DEFAULT CONTINUE BREAK
%token <symbolInfoPointer> PRINTLN
%token <symbolInfoPointer> RETURN

%token <symbolInfoPointer> ASSIGNOP LOGICOP RELOP ADDOP MULOP NOT
%token <symbolInfoPointer> INCOP DECOP
	// + , - ADDOP
	//*, /, % MULOP
	//++, - - INCOP
	//<, <=, >, >=, ==, != RELOP
	//&&, || LOGICOP
	// = ,ASSIGNOP
	// !  NOT

%token <symbolInfoPointer> INT FLOAT VOID CHAR DOUBLE

%token <symbolInfoPointer> CONST_FLOAT
%token <symbolInfoPointer> CONST_INT
%token <symbolInfoPointer> CONST_CHAR

%token <symbolInfoPointer> LPAREN LCURL LTHIRD
%token <symbolInfoPointer> RPAREN RCURL RTHIRD

%token <symbolInfoPointer> SEMICOLON COMMA
%token <symbolInfoPointer> ID

%token <symbolInfoPointer> STRING

%nonassoc SINGLE_IF
%nonassoc ELSE

%type <symbolInfoPointer> argument_list
%type <symbolInfoPointer> arguments
%type <symbolInfoPointer> compound_statement
%type <symbolInfoPointer> declaration_list
%type <symbolInfoPointer> expression
%type <symbolInfoPointer> expression_statement
%type <symbolInfoPointer> factor
%type <symbolInfoPointer> func_declaration
%type <symbolInfoPointer> func_definition
%type <symbolInfoPointer> logic_expression
%type <symbolInfoPointer> parameter_list
%type <symbolInfoPointer> program
%type <symbolInfoPointer> rel_expression
%type <symbolInfoPointer> simple_expression
%type <symbolInfoPointer> start
%type <symbolInfoPointer> statement
%type <symbolInfoPointer> statements
%type <symbolInfoPointer> term
%type <symbolInfoPointer> type_specifier
%type <symbolInfoPointer> unary_expression
%type <symbolInfoPointer> unit
%type <symbolInfoPointer> var_declaration
%type <symbolInfoPointer> variable

%%

start :  program
	{
		logstream<<"\nAt line no: "<<yylineno<<" start : program"<<endl;
		$$ = $1;
		print($$);
		delete $$;
	}
	;

program :  program unit
	{
		logstream<<"\nAt line no: "<<yylineno<<" program : program unit"<<endl;
		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	|  unit
	{
		logstream<<"\nAt line no: "<<yylineno<<" program : unit"<<endl;
		$$ = $1;
		print($$);
	}
	;

unit :  var_declaration
	{
		logstream<<"\nAt line no: "<<yylineno<<" unit : var_declaration"<<endl;
		$$ = $1;
		print($$);
	}
	|  func_declaration
	{
		logstream<<"\nAt line no: "<<yylineno<<" unit : func_declaration"<<endl;
		$$ = $1;
		print($$);
	}
	|  func_definition
	{
		logstream<<"\nAt line no: "<<yylineno<<" unit : func_definition"<<endl;
		$$ = $1;
		print($$);
	}
	;

func_declaration :  type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$5 -> push_back( $6 );
		$$ = $1;
		print($$);
	}
	|  type_specifier ID LPAREN RPAREN SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$$ = $1;
		print($$);
	}
	;

func_definition :  type_specifier ID LPAREN parameter_list RPAREN compound_statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$5 -> push_back( $6 );
		$$ = $1;
		print($$);
	}
	|  type_specifier ID LPAREN RPAREN compound_statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" func_definition : type_specifier ID LPAREN RPAREN compound_statement"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$$ = $1;
		print($$);
	}
	;

parameter_list :  parameter_list COMMA type_specifier ID
	{
		logstream<<"\nAt line no: "<<yylineno<<" parameter_list : parameter_list COMMA type_specifier ID"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$$ = $1;
		print($$);
	}
	|  parameter_list COMMA type_specifier
	{
		logstream<<"\nAt line no: "<<yylineno<<" parameter_list : parameter_list COMMA type_specifier"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	|  type_specifier ID
	{
		logstream<<"\nAt line no: "<<yylineno<<" parameter_list : type_specifier ID"<<endl;
		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	|  type_specifier
	{
		logstream<<"\nAt line no: "<<yylineno<<" parameter_list : type_specifier"<<endl;
		$$ = $1;
		print($$);
	}
	;

compound_statement :  LCURL{symboltable->enterScope();} statements RCURL{symboltable->printNonEmptyBuckets(logstream); symboltable->exitScope();}
	{
		logstream<<"\nAt line no: "<<yylineno<<" compound_statement : LCURL statements RCURL"<<endl;
		$1 -> push_back( $3 );
		$3 -> push_back( $4 );
		$$ = $1;
		print($$);
	}
	|  LCURL{symboltable->enterScope();} RCURL{symboltable->printNonEmptyBuckets(logstream); symboltable->exitScope();}
	{
		logstream<<"\nAt line no: "<<yylineno<<" compound_statement : LCURL RCURL"<<endl;
		$1 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

var_declaration :  type_specifier declaration_list SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" var_declaration : type_specifier declaration_list SEMICOLON"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

type_specifier :  INT
	{
		logstream<<"\nAt line no: "<<yylineno<<" type_specifier : INT"<<endl;
		$$ = $1;
		print($$);
	}
	|  FLOAT
	{
		logstream<<"\nAt line no: "<<yylineno<<" type_specifier : FLOAT"<<endl;
		$$ = $1;
		print($$);
	}
	|  VOID
	{
		logstream<<"\nAt line no: "<<yylineno<<" type_specifier : VOID"<<endl;
		$$ = $1;
		print($$);
	}
	;

declaration_list :  declaration_list COMMA ID
	{
		logstream<<"\nAt line no: "<<yylineno<<" declaration_list : declaration_list COMMA ID"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	|  declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
	{
		logstream<<"\nAt line no: "<<yylineno<<" declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$5 -> push_back( $6 );
		$$ = $1;
		print($$);
	}
	|  ID
	{
		logstream<<"\nAt line no: "<<yylineno<<" declaration_list : ID"<<endl;
		$$ = $1;
		print($$);
	}
	|  ID LTHIRD CONST_INT RTHIRD
	{
		logstream<<"\nAt line no: "<<yylineno<<" declaration_list : ID LTHIRD CONST_INT RTHIRD"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$$ = $1;
		print($$);
	}
	;

statements :  statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" statements : statement"<<endl;
		$$ = $1;
		print($$);
	}
	|  statements statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" statements : statements statement"<<endl;
		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	;

statement :  var_declaration
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : var_declaration"<<endl;
		$$ = $1;
		print($$);
	}
	|  expression_statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : expression_statement"<<endl;
		$$ = $1;
		print($$);
	}
	|  compound_statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : compound_statement"<<endl;
		$$ = $1;
		print($$);
	}
	|  FOR LPAREN expression_statement expression_statement expression RPAREN statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$5 -> push_back( $6 );
		$6 -> push_back( $7 );
		$$ = $1;
		print($$);
	}
	|  IF LPAREN expression RPAREN statement %prec SINGLE_IF
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : IF LPAREN expression RPAREN statement"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$$ = $1;
		print($$);
	}
	|  IF LPAREN expression RPAREN statement ELSE statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : IF LPAREN expression RPAREN statement ELSE statement"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$5 -> push_back( $6 );
		$6 -> push_back( $7 );
		$$ = $1;
		print($$);
	}
	|  WHILE LPAREN expression RPAREN statement
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : WHILE LPAREN expression RPAREN statement"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$$ = $1;
		print($$);
	}
	|  PRINTLN LPAREN ID RPAREN SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : PRINTLN LPAREN ID RPAREN SEMICOLON"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$$ = $1;
		print($$);
	}
	|  RETURN expression SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" statement : RETURN expression SEMICOLON"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

expression_statement :  SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" expression_statement : SEMICOLON"<<endl;
		$$ = $1;
		print($$);
	}
	|  expression SEMICOLON
	{
		logstream<<"\nAt line no: "<<yylineno<<" expression_statement : expression SEMICOLON"<<endl;
		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	;

variable :  ID
	{
		logstream<<"\nAt line no: "<<yylineno<<" variable : ID"<<endl;
		$$ = $1;
		print($$);
	}
	|  ID LTHIRD expression RTHIRD
	{
		logstream<<"\nAt line no: "<<yylineno<<" variable : ID LTHIRD expression RTHIRD"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$$ = $1;
		print($$);
	}
	;

expression :  logic_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" expression : logic_expression"<<endl;
		$$ = $1;
		print($$);
	}
	|  variable ASSIGNOP logic_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" expression : variable ASSIGNOP logic_expression"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

logic_expression :  rel_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" logic_expression : rel_expression"<<endl;
		$$ = $1;
		print($$);
	}
	|  rel_expression LOGICOP rel_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" logic_expression : rel_expression LOGICOP rel_expression"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

rel_expression :  simple_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" rel_expression : simple_expression"<<endl;
		$$ = $1;
		print($$);
	}
	|  simple_expression RELOP simple_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" rel_expression : simple_expression RELOP simple_expression"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

simple_expression :  term
	{
		logstream<<"\nAt line no: "<<yylineno<<" simple_expression : term"<<endl;
		$$ = $1;
		print($$);
	}
	|  simple_expression ADDOP term
	{
		logstream<<"\nAt line no: "<<yylineno<<" simple_expression : simple_expression ADDOP term"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

term :  unary_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" term : unary_expression"<<endl;
		$$ = $1;
		print($$);
	}
	|  term MULOP unary_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" term : term MULOP unary_expression"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

unary_expression :  ADDOP unary_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" unary_expression : ADDOP unary_expression"<<endl;
		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	|  NOT unary_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" unary_expression : NOT unary_expression"<<endl;
		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	|  factor
	{
		logstream<<"\nAt line no: "<<yylineno<<" unary_expression : factor"<<endl;
		$$ = $1;
		print($$);
	}
	;

factor :  variable
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : variable"<<endl;
		$$ = $1;
		print($$);
	}
	|  ID LPAREN argument_list RPAREN
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : ID LPAREN argument_list RPAREN"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$$ = $1;
		print($$);
	}
	|  LPAREN expression RPAREN
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : LPAREN expression RPAREN"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	|  CONST_INT
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : CONST_INT"<<endl;
		$$ = $1;
		print($$);
	}
	|  CONST_FLOAT
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : CONST_FLOAT"<<endl;
		$$ = $1;
		print($$);
	}
	|  variable INCOP
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : variable INCOP"<<endl;
		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	|  variable DECOP
	{
		logstream<<"\nAt line no: "<<yylineno<<" factor : variable DECOP"<<endl;
		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	;

argument_list :  arguments
	{
		logstream<<"\nAt line no: "<<yylineno<<" argument_list : arguments"<<endl;
		$$ = $1;
		print($$);
	}
	| 
	{
		logstream<<"\nAt line no: "<<yylineno<<" argument_list :"<<endl;
		$$=nullptr;
		print($$);
	}
	;

arguments :  arguments COMMA logic_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" arguments : arguments COMMA logic_expression"<<endl;
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	|  logic_expression
	{
		logstream<<"\nAt line no: "<<yylineno<<" arguments : logic_expression"<<endl;
		$$ = $1;
		print($$);
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
	symboltable = new SymbolTable<Info>();

	yyin=fp;
	yyparse();
	
	yylex_destroy();

	delete symboltable;

	errorstream<<"\nTotal Errors: "<<error_count<<endl;

	fclose(fp);
	
	
	return 0;
}

