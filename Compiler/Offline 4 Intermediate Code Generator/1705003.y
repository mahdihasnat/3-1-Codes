%{

#include<bits/stdc++.h>
using namespace std;

#include "SymbolInfo.h"
#include "SymbolTable.h"

#include "ParserFunctions.h"

#include "Info.h"
#include "ReutrnType.h"

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
vector< pair< string , int > > globals;
string currentFuncName = "";

#define FIXED_POINT_MULTIPLIER 100
#define gTL getTypeLocation

template<class T1,class T2>
ostream & operator << ( ostream & os ,const pair<T1,T2> &p)
{
	return os<<"{"<<p.first<<","<<p.second<<"}";
}

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
		DBG(error_count);
		
		if(noerror())
		{
			
			Code *code  = new Code(".MODEL SMALL");
			code = combine(code , ".STACK 1000H");

			code = combine(code , ".DATA");

			code = combine(code , "FIXED_POINT_MULTIPLIER DW 64H");

			for(pair<string,int > id_sz : globals)
			{
				code=combine(code , id_sz.first + " DW "+to_string(id_sz.second)+" DUP (0000H)");
			}
			code = combine(code , ".CODE");

			code = combine(code , loadLibrary());

			code = combine(code ,  $$ -> getTypeLocation()-> getCode());

			code = combine(
				code ,
				"END main"
			);


			ofstream codestream ;
			codestream.open("code.asm" , ios::trunc);
			
			// codestream<<(*code);
			code->write(codestream);


		}

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

		string funcName = $2 -> getName();

		if(noerror())
		{
			SymbolInfoPointer compoundStatement = $7;
			Code * code = functionCode(funcName , compoundStatement);
			$$ -> getTypeLocation()->setCode(code);
		}
		currentFuncName = "";

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

		string funcName = $2 -> getName();

		if(noerror())
		{
			SymbolInfoPointer compoundStatement = $6;
			Code * code = functionCode(funcName , compoundStatement);
			$$ -> getTypeLocation()->setCode(code);
		}
		currentFuncName = "";
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
		
		if(noerror())
		{
			
			Code * code = nullptr;
			
			code = combine(code , $3 -> getTypeLocation() -> getCode());
			code = combine(code ,exitScope());

			$$ -> getTypeLocation()->setCode(code);

		}
			
	}
	|  LCURL{enterScope();} RCURL
	{
		logRule("compound_statement : LCURL RCURL");
		$1 -> push_back( $3 );
		$$ = $1;
		print($$);

		if(noerror())
		{
			
			Code * code = nullptr;

			code = combine(code ,exitScope());

			$$ -> getTypeLocation()->setCode(code);
		}

	}
	;

var_declaration :  type_specifier declaration_list SEMICOLON
	{
		logRule("var_declaration : type_specifier declaration_list SEMICOLON");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
		
		if(noerror())
		{
			
			$$-> getTypeLocation()-> setCode( add_variable_declaration($$) );
		}
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

		if(noerror())
		{
			$$-> getTypeLocation()->setCode(
				combine(
					$1 -> getTypeLocation()->getCode(),
					$2 -> getTypeLocation()->getCode()
				)
			);
			
		}
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

		if(noerror())
		{
			

			Code * code_init = $3 -> gTL() -> getCode();
			Code * code_check = $4 -> gTL() -> getCode();
			Code * code_statement = $7 -> gTL() -> getCode();
			Code * code_step = $5 -> gTL() -> getCode();

			$$ -> gTL() -> setCode(
				loopImplementation(
					code_init,
					code_check,
					code_step,
					code_statement
				)
			);
		}
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

		if(noerror())
		{

			Code * code_init = $3 -> gTL() -> getCode();
			Code * code_check = $4 -> gTL() -> getCode();
			Code * code_statement = $6 -> gTL() -> getCode();
			Code * code_step = nullptr;

			$$ -> gTL() -> setCode(
				loopImplementation(
					code_init,
					code_check,
					code_step,
					code_statement
				)
			);
		}

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
		
		if(noerror())
		{
			$$ -> gTL() -> setCode(
				conditionImplementation(
					$3->gTL() -> getCode(),
					$5->gTL() -> getCode(),
					nullptr 
				)
			);
		}

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

		if(noerror())
		{
			$$ -> gTL() -> setCode(
				conditionImplementation(
					$3->gTL() -> getCode(),
					$5->gTL() -> getCode(),
					$7->gTL() -> getCode()
				)
			);
		}

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

		if(noerror())
		{
			$$ -> gTL() -> setCode(
				loopImplementation(
					nullptr,
					$3 -> gTL()->getCode(),
					nullptr,
					$5-> gTL()->getCode()
				)
			);
		}
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


		if(noerror())
		{

			string var_name = $3 -> getName();

			SymbolInfoPointer ref = symboltable -> lookUp(var_name);

			Code * code = nullptr;

			code = combine(
				code ,
				"MOV CX , "+getSingleVariableAddress(ref)
			);
			
			code = combine(
				code ,
				"PUSH CX"
			);

			string printFunc ="";

			switch (ref->getTypeLocation()->getReturnType())
			{
			case Int:
				printFunc = "println_int";
				break;
			case Float:
				printFunc = "println_float";
				break;
			default:
				assert(0);
				break;
			}

			code = combine(
				code ,
				"CALL "+printFunc
			);

			$$ -> getTypeLocation() -> setCode(
				code
			);
		}

	}
	|  RETURN expression SEMICOLON
	{
		logRule("statement : RETURN expression SEMICOLON");
		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);

		/// https://www.youtube.com/watch?v=z2_2cFityc4
		if(noerror())
		{
			// func()
			// {
			// 	int 
			// 	{
			// 		int 
			// 		return 
			// 	}
			// }
			Code * code = nullptr;

			code = combine(
				code ,
				$2 -> gTL() -> getCode()
			);

			int current_stack_offset = symboltable -> getBaseIndex();

			code = combine(code, "SUB SP , "+ to_string(current_stack_offset) );
			code = combine(code, "JMP "+currentFuncName + "_exit");

			$$ -> gTL() -> setCode( code );

		}
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
		
		$1->getTypeLocation()->setReturnType(Void);

		$$ = $1;
		print($$);

		if(noerror())
		{
			$1 -> gTL()->setCode( new Code("MOV CX , 1"));
		}

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
		
		string var_name = $1 -> getName() ;

		$1 -> getTypeLocation()-> setReturnType(getVariableType(var_name));
		
		$$ = $1;
		print($$);

	}
	|  ID LTHIRD expression RTHIRD
	{
		logRule("variable : ID LTHIRD expression RTHIRD");

		string array_name = $1 -> getName();

		$1 -> getTypeLocation()-> setReturnType(getArrayType(array_name ));
		
		if(getReturnTypeFromSIP($3) != Int)
		{
			if( getReturnTypeFromSIP($3) != Error )
				// yyerror("Non-integer Array Index index type : "+ $3 -> getTypeLocation() -> getReturnType());
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

		ReturnType type1 = getReturnTypeFromSIP($1);
		ReturnType type2 = getReturnTypeFromSIP($3);

		if( assignAbleType(type1 ,    type2 ) == false ){
			if(type1 != Error and type2 != Error)
				yyerror("Type Mismatch : "+ to_string(type1) + " " + $2 -> getName() + " " + to_string(type2));
		}
			
		$1 -> getTypeLocation() -> setReturnType(type1);
		

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);


		if(noerror())
		{

			$$ -> getTypeLocation() -> setCode( 
				writeToVariable(
					$1 ,
					$3 -> gTL() -> getCode()
				)
			 );

		}
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

		ReturnType type1  = $1->getTypeLocation()->getReturnType();
		ReturnType type2  = $3->getTypeLocation()->getReturnType();
		ReturnType resultType = Error;

		if(type1!=Int or type2 != Int ){
			if(type1 != Error and type2 != Error)
				yyerror("Type mismatch of Logic operation : " + to_string(type1) + " "+ $2 ->getTypeLocation()->getType() +  " " + to_string(type2));
		}
		else 
			resultType = Int;

		$1 -> getTypeLocation() -> setReturnType(resultType);

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);

		if(noerror())
		{
			Code * code  = nullptr;
			string op = $2 -> getName();
			if(op == "&&")	
			{
				string end_label = newLabel("after_and");
				code = combine(code , $1 -> getTypeLocation() -> getCode());
				code = combine(code ,"JCXZ "+end_label );
				code = combine(code , $3 -> getTypeLocation() -> getCode());
				code = combine(code , end_label + ":");
			}
			else if(op == "||")
			{
				string end_label = newLabel("after_or");
				code = combine(code , $1 -> getTypeLocation() -> getCode());
				code = combine(code ,"CMP CX , 0");
				code = combine(code ,"JNZ "+end_label );
				code = combine(code , $3 -> getTypeLocation() -> getCode());
				code = combine(code , end_label + ":");
			}
			else assert(0);

			$$ -> getTypeLocation()-> setCode(code);
		}

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

		ReturnType type1 = getReturnTypeFromSIP($1);
		ReturnType type2 = getReturnTypeFromSIP($3);
		ReturnType resultType = Error;
		if(type1 == Error or type2 == Error)
			;
		else if(type1 == Void or type2 == Void )
			yyerror("Type mismatch of relational operation : " + to_string(type1) + " "+ $2 ->getTypeLocation()->getType() +  " " + to_string(type2));
		else 
			resultType = Int;
		
		$1 -> getTypeLocation() -> setReturnType(resultType);

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);

		if(noerror())
		{
			/// notice: stack is pushed for temp variable
			
			Code * code  = nullptr;
			code = combine(code,Comment("Relational operator checking"));
			code = combine(
				code ,
				$1 -> getTypeLocation()->getCode()
			);
			// cx = simple expr
			bool to_float = type1 ==Float or type2 == Float;
			
			if(to_float and type1 != Float)
			{
				code = combine(code , Comment("Int to float"));
				code = combine(code , "MOV AX , CX");
				code = combine(code , "IMUL FIXED_POINT_MULTIPLIER");
				code = combine(code , "MOV CX , AX");
			}

			code = combine(code , "PUSH CX");
				//inside push
				code = combine(
					code ,
					$3 -> getTypeLocation()->getCode()
				);
				if(to_float and type2 != Float)
				{
					code = combine(code , Comment("Int to float"));
					code = combine(code , "MOV AX , CX");
					code = combine(code , "IMUL FIXED_POINT_MULTIPLIER");
					code = combine(code , "MOV CX , AX");
				}

			code = combine(code , "POP AX");

			// ax = arg1 , cx = arg2

			string op = $2 -> getName();
			string opcode = "";

			if(op == "<") opcode ="JL";
			else if(op == ">") opcode ="JG";
			else if(op == ">=") opcode ="JGE";
			else if(op == "<=") opcode ="JLE";
			else if(op == "==") opcode ="JE";
			else if(op == "!=") opcode ="JNE";
			else assert(0);

			code = combine(code , "CMP AX , CX");


			int labelCounter = newLabelCounter();
			string label_ok = "relop_is_ok" + to_string(labelCounter);
			string label_end = "relop_end"+ to_string(labelCounter);

			code = combine(code , opcode + " " + label_ok);
			code = combine(code , "MOV CX , 0");
			code = combine(code , "JMP " + label_end);
			code = combine(code , label_ok + ":");
			code = combine(code , "MOV CX , 1");
			code = combine(code , label_end + ":");

			$$ -> getTypeLocation()-> setCode(code);
		}	
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

		ReturnType type1 = getReturnTypeFromSIP($1);
		ReturnType type2 = getReturnTypeFromSIP($3);

		$1 -> getTypeLocation() -> setReturnType( combineArithmaticType(type1 , type2) );

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
		
		if(noerror())
		{
			Code * code  = nullptr;
			string op = $2 -> getName();
			string opcode = "";
			
			if(op == "+")	opcode = "ADD";
			else if(op == "-")	opcode = "SUB";
			else assert(0);
			
			code = combine(code , $1 -> getTypeLocation() -> getCode());
			code = combine(code ,"PUSH CX");
				code = combine(code , $3 -> getTypeLocation() -> getCode());
			code = combine(code ,"POP AX");
			
			// ax = simple expr , cx = term

			if((type1 == Int xor type2 == Int))
			{
				
				if(type2 == Int)
				{
					code = combine(code , "XCHG AX , CX");
				}
				// ax -> int
				// cx -> float
				
				code = combine(code , "IMUL FIXED_POINT_MULTIPLIER");
				// dx:ax = ax * FIXED_POINT_MULTIPLIER

				// swap back 
				if(type2 == Int)
				{
					code = combine(code , "XCHG AX , CX");
				}

			}

			code = combine(code , opcode + " AX , CX");
			code = combine(code , "MOV CX , AX");
	
			$$ -> getTypeLocation()-> setCode(code);
		}
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

		ReturnType type1 = getReturnTypeFromSIP($1);
		ReturnType type2 = getReturnTypeFromSIP($3);
		ReturnType resultType  = Error;
		if($2 -> getName() == "%")
		{
			if(type1 != Int or type2 != Int) 
			{
				if(type1 != Error and type2 != Error)
					yyerror("Non-Integer operand on modulus operator");
			}
			else if( isZero($3 -> getName()) )
				yyerror("Modulus by Zero");
			else
				resultType = Int;
		}
		else 
			resultType  = combineArithmaticType(type1 , type2);
	
		$1 -> getTypeLocation() -> setReturnType( resultType);

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);

		if(noerror())
		{
			Code * code  = nullptr;
			string op = $2 -> getName();
			
			
			code = combine(code , ";>>");
			code = combine(code , Comment(op));

			code = combine(code , $1 -> getTypeLocation() -> getCode());
			code = combine(code ,"PUSH CX");
				code = combine(code , $3 -> getTypeLocation() -> getCode());
			code = combine(code ,"POP AX");

			// ax = term , cx = unary
			
			if(op == "*")
			{
				code = combine(code , "IMUL CX");
				if(type1 == Float and type2 == Float)
				{
					code = combine(code , "IDIV " + to_string(FIXED_POINT_MULTIPLIER));
				}
				code = combine(code , "MOV CX , AX");
			}
			else if(op == "/")
			{
				
				// ax = term ,cx = unary , term/unary
				switch (type1)
				{
				case Int:
					switch (type2)
					{
					case Int:
						code = combine(code , "CWD");
						break;
					case Float:
						code = combine(code , "IMUL FIXED_POINT_MULTIPLIER");
						code = combine(code , "IMUL FIXED_POINT_MULTIPLIER");
						break;
					default:
						assert(0);
						break;
					}
					break;
				case Float:
					switch (type2)
					{
					case Int:
						code = combine(code , "CWD");
						break;
					case Float:
						code = combine(code , "IMUL FIXED_POINT_MULTIPLIER");
						break;
					default:
						assert(0);
						break;
					}
					break;
				default:
					assert(0);
					break;
				}
				code = combine(code , "IDIV CX");
				code = combine(code , "MOV CX , AX");
				
			}
			else if(op == "%")
			{
				code = combine(code , "CWD");
				code = combine(code , "IDIV CX");
				code = combine(code , "MOV CX , DX");

			}
			else assert(0);
			
			code = combine(code , ";<<");

			$$ -> getTypeLocation()-> setCode(code);
		}
	}
	;

unary_expression :  ADDOP unary_expression
	{
		logRule("unary_expression : ADDOP unary_expression");

		ReturnType type = getReturnTypeFromSIP($2);
		ReturnType resultType = Error;

		switch (type)
		{
		case Void:
			yyerror("Void statement used in expression");
			break;

		default:
			resultType = type;
			break;
		}

		$1->getTypeLocation()->setReturnType(resultType);

		$1->push_back($2);
		$$ = $1;
		print($$);

		if(noerror())
		{
			Code * code  = nullptr;
			string op = $1 -> getName();
			
			code = combine(code , $2 -> getTypeLocation() -> getCode());
			
			if(op == "+")	;
			else if(op == "-")	code = combine(code , "NEG CX");
			else assert(0);

			$$ -> getTypeLocation()-> setCode(code);
		}

	}
	|  NOT unary_expression
	{
		logRule("unary_expression : NOT unary expression");

		ReturnType type = $2->getTypeLocation()->getReturnType();
		ReturnType resultType = Error;

		switch (type)
		{
		case Void:
			yyerror("Void statement used in expression");
			break;

		case Float:
			yyerror("Invalid not operation for float type");
			break;

		case Int:
			resultType = Int;
			break;
		
		default:
			break;
		}

		$1->getTypeLocation()->setReturnType(resultType);

		$1 -> push_back( $2 );
		$$ = $1;
		print($$);

		if(noerror())
		{
			Code * code  = nullptr;
			

			code = combine(code , $2 -> getTypeLocation() -> getCode());
			

			int labelCounter = newLabelCounter();
			string label_end = "not_end" + to_string(labelCounter);
			string label_one = "not_one" + to_string(labelCounter);

			code = combine(code , "JCXZ "+label_one);
			code = combine(code , "MOV CX , 0");
			code = combine(code , "JMP "+label_end);
			code = combine(code , label_one + ":");
			code = combine(code , "MOV CX , 1");
			code = combine(code , label_end + ":");


			$$ -> getTypeLocation()-> setCode(code);
		}


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
		
		if(noerror())
			readFromVariable($$);

	}
	|  ID LPAREN argument_list RPAREN
	{
		logRule("factor : ID LPAREN argument_list RPAREN");

		string funcName = $1 -> getName() ;

		$1 -> getTypeLocation() -> setReturnType( getFuncReturnType(funcName, $3) );

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$3 -> push_back( $4 );
		$$ = $1;
		print($$);

		if(noerror())
		{
			Code * code = nullptr ;

			code = combine(
				code ,
				$3 ? $3 -> gTL() ->getCode() : nullptr
			);

			code = combine(code, "CALL "+funcName);

			$$ -> gTL() -> setCode(code);
		}

	}
	|  LPAREN expression RPAREN
	{
		logRule("factor : LPAREN expression RPAREN");

		$1 -> getTypeLocation()->setReturnType( getReturnTypeFromSIP($2));

		$1 -> push_back( $2 );
		$2 -> push_back( $3 );
		$$ = $1;
		print($$);
		if(noerror())
		{
			$$ -> getTypeLocation() -> setCode(
				$2 -> getTypeLocation()->getCode()
			);
		}
	}
	|  CONST_INT
	{
		logRule("factor : CONST_INT");

		$1->getTypeLocation() -> setReturnType(Int);

		$$ = $1;
		print($$);

		

		if(noerror())
		{	
			string num_str = $$ -> getName();

			$$ -> getTypeLocation()->setCode(
				combine(
					new Code(Comment("integar = "+ num_str) ) ,
					"MOV CX , " + num_str   
				)
			);
		}
	}
	|  CONST_FLOAT
	{
		logRule("factor : CONST_FLOAT");

		$1->getTypeLocation() -> setReturnType(Float);

		$$ = $1;
		print($$);

		if(noerror())
		{
			int num = stof( $$ -> getName() ) * FIXED_POINT_MULTIPLIER;
			
			$$ -> getTypeLocation()->setCode(
				combine(
					new Code(Comment("float number = "+ $$ -> getName()) ) ,
					"MOV CX , " + to_string(num)
				)
			);
		}
		
	}
	|  variable INCOP
	{
		logRule("factor : variable INCOP");


		ReturnType type = getReturnTypeFromSIP($1);
		ReturnType resultType = Error;

		switch (type)
		{
		case Void:
			yyerror("Void statement used in expression");
			break;

		case Int:
		case Float:
			resultType = type;
			break;
			
		default:
			break;
		}

		$1 -> getTypeLocation() -> setReturnType(resultType);

		// if(getReturnTypeFromSIP($1) != Int and getReturnTypeFromSIP($1) != Float )
		// 	yyerror("Type Mismatch : "+ to_string(getReturnTypeFromSIP($1)) + " INCOP");

		$1 -> push_back( $2 );
		$$ = $1;
		print($$);

		if(noerror())
		{
			Code *code = nullptr;
			SymbolInfoPointer sip = $1;

			string var_name = sip->getName();
			SymbolInfoPointer ref = symboltable->lookUp(var_name);
			assert(ref);

			int changeAmount = 1;
			if(resultType == Int) changeAmount = 1;
			else if(resultType == Float) changeAmount = FIXED_POINT_MULTIPLIER;
			else assert(0);

			if (ref->getTypeLocation()->isArray())
			{
				SymbolInfoPointer expr = sip->getNextSymbolInfo()->getNextSymbolInfo();

				code = combine(
					code,
					expr->getTypeLocation()->getCode() /// CX e expr ache
				);

				int idx = ref->getTypeLocation()->getBasedIndex();

				if (idx == -1)
				{
					code = combine(code, Comment("set  element to memory array"));
					code = combine(code, "SAL CX , 1"); 
					code = combine(code, "MOV BX , CX");
					code = combine(code, "MOV CX , PTR WORD " + var_name + "[BX]");
					code = combine(code, "MOV AX , CX");
					code = combine(code, "ADD AX , " +to_string(changeAmount) );
					code = combine(code, "MOV PTR WORD " + var_name + "[BX] , AX");
				}
				else
				{
					code = combine(code, Comment("put element to stack array"));
					code = combine(code, "PUSH BP");
						code = combine(code, "SAL CX , 1");
						code = combine(code, "ADD CX , " + to_string(idx));
						code = combine(code, "ADD BP , CX");
						code = combine(code, "MOV CX , PTR WORD [BP]");
						code = combine(code, "MOV AX , CX");
						code = combine(code, "ADD AX , " +to_string(changeAmount) );
						code = combine(code, "MOV PTR WORD [BP] , AX");
					code = combine(code, "POP BP");
				}
			}
			else
			{
				
				code = combine(code, "MOV CX , " + getSingleVariableAddress(ref));
				code = combine(code, "MOV AX , CX");
				code = combine(code, "ADD AX , " +to_string(changeAmount) );
				code = combine(code, "MOV " + getSingleVariableAddress(ref) + " , AX");
			}
			
			$$ -> gTL()->setCode(
				code
			);
		}

	}
	|  variable DECOP
	{
		logRule("factor : variable DECOP");

		ReturnType type = getReturnTypeFromSIP($1);
		ReturnType resultType = Error;

		switch (type)
		{
		case Void:
			yyerror("Void statement used in expression");
			break;

		case Int:
		case Float:
			resultType = type;
			break;

		default:
			break;
		}

		// if(getReturnTypeFromSIP($1) != Int and getReturnTypeFromSIP($1) != Float )
		// 	yyerror("Type Mismatch : "+ to_string(getReturnTypeFromSIP($1)) + " DECOP");

		$1 -> getTypeLocation() -> setReturnType(resultType);

		$1 -> push_back( $2 );
		$$ = $1;
		print($$);

		if(noerror())
		{
			Code *code = nullptr;
			SymbolInfoPointer sip = $1;

			string var_name = sip->getName();
			SymbolInfoPointer ref = symboltable->lookUp(var_name);
			assert(ref);

			int changeAmount = 1;
			if(resultType == Int) changeAmount = 1;
			else if(resultType == Float) changeAmount = FIXED_POINT_MULTIPLIER;
			else assert(0);

			if (ref->getTypeLocation()->isArray())
			{
				SymbolInfoPointer expr = sip->getNextSymbolInfo()->getNextSymbolInfo();

				code = combine(
					code,
					expr->getTypeLocation()->getCode() /// CX e expr ache
				);

				int idx = ref->getTypeLocation()->getBasedIndex();

				if (idx == -1)
				{
					code = combine(code, Comment("set  element to memory array"));
					code = combine(code, "SAL CX , 1"); 
					code = combine(code, "MOV BX , CX");
					code = combine(code, "MOV CX , PTR WORD " + var_name + "[BX]");
					code = combine(code, "MOV AX , CX");
					code = combine(code, "SUB AX , " +to_string(changeAmount) );
					code = combine(code, "MOV PTR WORD " + var_name + "[BX] , AX");
				}
				else
				{
					code = combine(code, Comment("put element to stack array"));
					code = combine(code, "PUSH BP");
						code = combine(code, "SAL CX , 1");
						code = combine(code, "ADD CX , " + to_string(idx));
						code = combine(code, "ADD BP , CX");
						code = combine(code, "MOV CX , PTR WORD [BP]");
						code = combine(code, "MOV AX , CX");
						code = combine(code, "SUB AX , " +to_string(changeAmount) );
						code = combine(code, "MOV PTR WORD [BP] , AX");
					code = combine(code, "POP BP");
				}
			}
			else
			{
				
				code = combine(code, "MOV CX , " + getSingleVariableAddress(ref));
				code = combine(code, "MOV AX , CX");
				code = combine(code, "SUB AX , " +to_string(changeAmount) );
				code = combine(code, "MOV " + getSingleVariableAddress(ref) + " , AX");
			}
			
			$$ -> gTL()->setCode(
				code
			);
		}

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
		
		if(noerror()){
			$$ -> gTL() -> setCode(
				combine(
					combine(
						$3 -> gTL()->getCode(),
						"PUSH CX"
					),
					$1 -> gTL()->getCode() 
				)
				
			);
		}

	}
	|  logic_expression
	{
		logRule("arguments : logic_expression");
		$1 -> getTypeLocation()->getParametersLocation()->push_back(getReturnTypeFromSIP($1));
		$$ = $1;
		print($$);

		if(noerror()){
			$$ -> gTL() -> setCode(
				combine(
					$1 -> gTL()->getCode(),
					"PUSH CX"
				)
			);
		}
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

		if(noerror()){
			$$ -> gTL() -> setCode(
				combine(
					$2 -> gTL()->getCode(),
					"PUSH CX"
				)
			);
		}
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

