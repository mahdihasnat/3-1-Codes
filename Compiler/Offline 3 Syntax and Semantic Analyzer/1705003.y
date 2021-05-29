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
		logRule("start : program");
		$$ = $1;
		//print($$);
		delete $$;
	}
	;

program :  program unit
	{
		logRule("program : program unit");
		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	|  unit
	{
		logRule("program : unit");
		$$ = $1;
		print($$);
	}
	;

unit :  var_declaration
	{
		logRule("unit : var_declaration");
		$$ = $1;
		print($$);
	}
	|  func_declaration
	{
		logRule("unit : func_declaration");
		$$ = $1;
		print($$);
	}
	|  func_definition
	{
		logRule("unit : func_definition");
		$$ = $1;
		print($$);
	}
	| error SEMICOLON
	{
		logRule("unit :  error SEMICOLON");
		$$  = $2;
		print($$);
	}
	;

func_declaration :  type_specifier ID LPAREN parameter_list RPAREN SEMICOLON
	{
		logRule("func_declaration : type_specifier ID LPAREN parameter_list RPAREN SEMICOLON");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$5 -> push_back( $6 );
		$$ = $1;
		print($$);

		add_func_declaration($1,$2,$4);

	}
	|  type_specifier ID LPAREN RPAREN SEMICOLON
	{
		logRule("func_declaration : type_specifier ID LPAREN RPAREN SEMICOLON");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$$ = $1;
		print($$);

		add_func_declaration($1,$2,nullptr);

	}
	;

func_definition :  type_specifier ID LPAREN parameter_list RPAREN {add_func_definition($1 , $2 , $4);} compound_statement
	{
		logRule("func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$5 -> push_back( $7 );
		$$ = $1;
		print($$);
	}
	|  type_specifier ID LPAREN RPAREN {add_func_definition($1 , $2 , nullptr);} compound_statement
	{
		logRule("func_definition : type_specifier ID LPAREN RPAREN compound_statement");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $6 );
		$$ = $1;
		print($$);
	}
	;

parameter_list :  parameter_list COMMA type_specifier ID
	{
		logRule("parameter_list : parameter_list COMMA type_specifier ID");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$$ = $1;
		print($$);
	}
	|  parameter_list COMMA type_specifier
	{
		logRule("parameter_list : parameter_list COMMA type_specifier");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	|  type_specifier ID
	{
		logRule("parameter_list : type_specifier ID");
		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	|  type_specifier
	{
		logRule("parameter_list : type_specifier");
		$$ = $1;
		print($$);
	}
	| parameter_list error
	{
		logRule("parameter_list : parameter_list error");
		$$ = $1;
		print($$);
	}
	;

compound_statement :  LCURL{enterScope();} statements RCURL
	{
		logRule("compound_statement : LCURL statements RCURL");
		$1 -> push_back( $3 );
		$3 -> push_back( $4 );
		$$ = $1;
		print($$);
		exitScope();
	}
	|  LCURL{enterScope();} RCURL
	{
		logRule("compound_statement : LCURL RCURL");
		$1 -> push_back( $3 );
		$$ = $1;
		print($$);

		exitScope();
	}
	;

var_declaration :  type_specifier declaration_list SEMICOLON
	{
		logRule("var_declaration : type_specifier declaration_list SEMICOLON");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
		add_variable_declaration($$);
	}
	| type_specifier error SEMICOLON 
	{
		logRule("var_declaration : type_specifier error SEMICOLON");
		$1 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

type_specifier :  INT
	{
		logRule("type_specifier : INT");
		$$ = $1;
		print($$);
	}
	|  FLOAT
	{
		logRule("type_specifier : FLOAT");
		$$ = $1;
		print($$);
	}
	|  VOID
	{
		logRule("type_specifier : VOID");
		$$ = $1;
		print($$);
	}
	;

declaration_list :  declaration_list COMMA ID
	{
		logRule("declaration_list : declaration_list COMMA ID");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	|  declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
	{
		logRule("declaration_list : declaration_list COMMA ID LTHIRD CONST_INT RTHIRD");
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
		logRule("declaration_list : ID");
		$$ = $1;
		print($$);
	}
	|  ID LTHIRD CONST_INT RTHIRD
	{
		logRule("declaration_list : ID LTHIRD CONST_INT RTHIRD");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$$ = $1;
		print($$);
	}
	| declaration_list error 
	{
		logRule("declaration_list : declaration_list error");
		$$ = $1 ;
		print($$);
	}
	;

statements :  statement
	{
		logRule("statements : statement");
		$$ = $1;
		print($$);
	}
	|  statements statement
	{
		logRule("statements : statements statement");
		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	| statements error
	{
		logRule("statements : statements error");
		$$ = $1;
		print($$);
	}
	;

statement :  var_declaration
	{
		logRule("statement : var_declaration");
		$$ = $1;
		print($$);
	}
	|  expression_statement
	{
		logRule("statement : expression_statement");
		$$ = $1;
		print($$);
	}
	|  compound_statement
	{
		logRule("statement : compound_statement");
		$$ = $1;
		print($$);
	}
	|  FOR LPAREN expression_statement expression_statement expression RPAREN statement
	{
		logRule("statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$5 -> push_back( $6 );
		$6 -> push_back( $7 );
		$$ = $1;
		print($$);
	}
	|  FOR LPAREN expression_statement expression_statement RPAREN statement
	{
		logRule("statement : FOR LPAREN expression_statement expression_statement RPAREN statement");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$5 -> push_back( $6 );
		$$ = $1;
		print($$);
	}
	|  IF LPAREN expression RPAREN statement %prec SINGLE_IF
	{
		logRule("statement : IF LPAREN expression RPAREN statement");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$$ = $1;
		print($$);
	}
	|  IF LPAREN expression RPAREN statement ELSE statement
	{
		logRule("statement : IF LPAREN expression RPAREN statement ELSE statement");
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
		logRule("statement : WHILE LPAREN expression RPAREN statement");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$$ = $1;
		print($$);
	}
	|  PRINTLN LPAREN ID RPAREN SEMICOLON
	{
		logRule("statement : PRINTLN LPAREN ID RPAREN SEMICOLON");

		$3 -> getTypeLocation() -> setReturnType( getVariableType( $3 -> getName() ) );

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$4 -> push_back( $5 );
		$$ = $1;
		print($$);
	}
	|  RETURN expression SEMICOLON
	{
		logRule("statement : RETURN expression SEMICOLON");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	| func_declaration
	{
		logRule("statement : func_declaration");
		$$ = $1;
		print($$);
		//yyerror("Function declaration is not in global scope");
	}
	| func_definition
	{
		logRule("statement : func_definition");
		$$ = $1;
		print($$);
		yyerror("Function defination is not in global scope");
	}
	;

expression_statement :  SEMICOLON
	{
		logRule("expression_statement : SEMICOLON");
		
		$1->getTypeLocation()->setReturnType("VOID");

		$$ = $1;
		print($$);
	}
	|  expression SEMICOLON
	{
		logRule("expression_statement : expression SEMICOLON");
		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	;

variable :  ID
	{
		logRule("variable : ID");
		
		$1 -> getTypeLocation()-> setReturnType(getVariableType($1 -> getName() ));
		
		$$ = $1;
		print($$);
	}
	|  ID LTHIRD expression RTHIRD
	{
		logRule("variable : ID LTHIRD expression RTHIRD");

		$1 -> getTypeLocation()-> setReturnType(getArrayType($1 -> getName()  ));
		
		if(getReturnTypeFromSIP($3) != "INT")
		{
			//yyerror("Non-integer Array Index index type : "+ $3 -> getTypeLocation() -> getReturnType());
			yyerror("Expression inside third brackets not an integer");
		}

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$$ = $1;
		print($$);
	}
	;

expression :  logic_expression
	{
		logRule("expression : logic expression");
		$$ = $1;
		print($$);
	}
	|  variable ASSIGNOP logic_expression
	{
		logRule("expression : variable ASSIGNOP logic_expression");

		string type1 = getReturnTypeFromSIP($1);
		string type2 = getReturnTypeFromSIP($3);

		if( assignAbleType(type1 ,    type2 ) == false )
			yyerror("Type Mismatch : "+type1 + " " + $2 -> getName() + " " + type2);
			
		$1 -> getTypeLocation() -> setReturnType(type1);
		

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

logic_expression :  rel_expression
	{
		logRule("logic_expression : rel_expression");
		$$ = $1;
		print($$);
	}
	|  rel_expression LOGICOP rel_expression
	{
		logRule("logic_expression : rel_expression LOGICOP rel_expression");

		string type1  = $1->getTypeLocation()->getReturnType();
		string type2  = $3->getTypeLocation()->getReturnType();
		string resultType = "ERROR";

		if(type1!="INT" or type2 != "INT" )
			yyerror("Type mismatch of Logic operation : " + type1 + " "+ $2 ->getTypeLocation()->getType() +  " " + type2);
		else 
			resultType = "INT";

		$1 -> getTypeLocation() -> setReturnType(resultType);

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

rel_expression :  simple_expression
	{
		logRule("rel_expression : simple_expression");

		$$ = $1;
		print($$);
	}
	|  simple_expression RELOP simple_expression
	{
		logRule("rel_expression : simple_expression RELOP simple_expression");

		string type1 = getReturnTypeFromSIP($1);
		string type2 = getReturnTypeFromSIP($3);
		string resultType = "ERROR";

		if(type1 == "ERROR" or type2 == "ERROR" or type1 == "VOID" or type2 == "VOID" )
			yyerror("Type mismatch of relational operation : " + type1 + " "+ $2 ->getTypeLocation()->getType() +  " " + type2);
		else 
			resultType = "INT";
		
		$1 -> getTypeLocation() -> setReturnType(resultType);

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

simple_expression :  term
	{
		logRule("simple_expression : term");
		$$ = $1;
		print($$);
	}
	|  simple_expression ADDOP term
	{
		logRule("simple_expression : simple_expression ADDOP term");

		$1 -> getTypeLocation() -> setReturnType( combineArithmaticType(getReturnTypeFromSIP($1) , getReturnTypeFromSIP($3)) );

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

term :  unary_expression
	{
		logRule("term : unary_expression");
		$$ = $1;
		print($$);
	}
	|  term MULOP unary_expression
	{
		logRule("term : term MULOP unary_expression");

		string type1 = getReturnTypeFromSIP($1);
		string type2 = getReturnTypeFromSIP($3);
		string resultType  = "ERROR";
		if($2 -> getName() == "%")
		{
			if(type1 != "INT" or type2 != "INT")
				yyerror("Non-Integer operand on modulus operator");
			else if( stoi($3 -> getName()) == 0)
				yyerror("Modulus by Zero");
			resultType = "INT";
		}
		else 
			resultType  = combineArithmaticType(type1 , type2);
	
		$1 -> getTypeLocation() -> setReturnType( resultType);

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	;

unary_expression :  ADDOP unary_expression
	{
		logRule("unary_expression : ADDOP unary_expression");

		string resultType = "ERROR";
		if(getReturnTypeFromSIP($2) == "VOID")
			yyerror("Type Mismatch : PLUS VOID");
		else 
			resultType = getReturnTypeFromSIP($2);

		$1 -> getTypeLocation() -> setReturnType( resultType);
		

		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	|  NOT unary_expression
	{
		logRule("unary_expression : NOT unary expression");

		string type = $2->getTypeLocation() -> getReturnType();
		string resultType =  assignAbleType("INT" , type) ? "INT" : "ERROR";

		if(resultType == "ERROR")
			yyerror("Type Mismatch : NOT "+ type);

		$1 -> getTypeLocation() -> setReturnType( resultType );

		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	|  factor
	{
		logRule("unary_expression : factor");
		$$ = $1;
		print($$);
	}
	;

factor :  variable
	{
		logRule("factor : variable");
		$$ = $1;
		print($$);
	}
	|  ID LPAREN argument_list RPAREN
	{
		logRule("factor : ID LPAREN argument_list RPAREN");

		$1 -> getTypeLocation() -> setReturnType( getFuncReturnType($1 -> getName() , $3) );

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$$ = $1;
		print($$);
	}
	|  LPAREN expression RPAREN
	{
		logRule("factor : LPAREN expression RPAREN");

		$1 -> getTypeLocation()->setReturnType( getReturnTypeFromSIP($2));

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	|  CONST_INT
	{
		logRule("factor : CONST_INT");

		$1->getTypeLocation() -> setReturnType("INT");

		$$ = $1;
		print($$);
	}
	|  CONST_FLOAT
	{
		logRule("factor : CONST_FLOAT");

		$1->getTypeLocation() -> setReturnType("FLOAT");

		$$ = $1;
		print($$);
	}
	|  variable INCOP
	{
		logRule("factor : variable INCOP");

		if(getReturnTypeFromSIP($1) != "INT" and getReturnTypeFromSIP($1) != "FLOAT" )
			yyerror("Type Mismatch : "+ getReturnTypeFromSIP($1) + " INCOP");

		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	|  variable DECOP
	{
		logRule("factor : variable DECOP");

		if(getReturnTypeFromSIP($1) != "INT" and getReturnTypeFromSIP($1) != "FLOAT" )
			yyerror("Type Mismatch : "+ getReturnTypeFromSIP($1) + " DECOP");

		$1 -> push_back( $2 );
		$$ = $1;
		print($$);
	}
	;

argument_list :  arguments
	{
		logRule("argument_list : arguments");
		$$ = $1;
		print($$);
	}
	| 
	{
		logRule("argument_list :");
		$$=nullptr;
		print($$);
	}
	| error
	{
		logRule("argument_list : error");
		$$ = nullptr;
	}
	;

arguments :  arguments COMMA logic_expression
	{
		logRule("arguments : arguments COMMA logic_expression");

		$1 -> getTypeLocation()->getParametersLocation()->push_back(getReturnTypeFromSIP($3));

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
	}
	|  logic_expression
	{
		logRule("arguments : logic_expression");
		$1 -> getTypeLocation()->getParametersLocation()->push_back(getReturnTypeFromSIP($1));
		$$ = $1;
		print($$);
	}
	| arguments error
	{
		logRule("arguments : arguments error");
		$$ = $1;
		print($$);
	}
	| error logic_expression
	{
		logRule("arguments : error logic_expression");
		$$ = $2;
		$$ ->  getTypeLocation()->getParametersLocation()->push_back(getReturnTypeFromSIP($$));
		print($$);
	}
	;
%%
int main(int argc,char *argv[])
{

	if(argc < 2 )
	{
		printf("Provide input_file [log_file=log.txt] [error_file=error.txt]");
		exit(1);
	}

	FILE * fp ;

	fp=fopen(argv[1],"r");
	if( fp == NULL)
	{
		printf("Cannot Open Input File.\n");
		exit(1);
	}

	string log_file = argc >= 3 ? string(argv[2]) : "log.txt";
	string error_file = argc >= 4 ? string(argv[3]) : "error.txt";
	

	logstream.open(log_file , ios::out);
	errorstream.open(error_file , ios::out);
	
	

	ScopeTable<Info>::setTotalBucket(30);
	symboltable = new SymbolTable<Info>();

	yyin=fp;
	yyparse();
	
	

	//logstream<<"\n\t\tsymbol table:\n";
	symboltable->printNonEmptyBuckets(logstream);

	logstream<<"\nTotal lines: "<<yylineno<<endl;
	logstream<<"Total errors: "<<error_count<<endl<<endl;
	errorstream<<"\nTotal errors: "<<error_count<<endl;
	

	yylex_destroy();
	delete symboltable;

	fclose(fp);
	
	
	return 0;
}

