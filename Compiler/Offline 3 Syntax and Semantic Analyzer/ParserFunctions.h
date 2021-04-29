#ifndef ADDED_PARSERFUNCTIONS
#define ADDED_PARSERFUNCTIONS

#include<bits/stdc++.h>
using namespace std;

#include "Info.h"
#include "SymbolTable.h"

#define DBG(a) cerr<< "line "<<__LINE__ <<" : "<< #a <<" --> "<<(a)<<endl
#define NL cerr<<endl

#define getReturnTypeFromSIP(sip) sip -> getTypeLocation()->getReturnType()

extern int yylineno;
extern char * yytext;
extern int error_count;
extern SymbolTable<Info> *symboltable;

extern ofstream logstream;
extern ofstream errorstream;

SymbolInfoPointer lazy_parameters;

void yyerror(const string &s)
{
	error_count++;
	
	errorstream<<"Error at line "<<yylineno<<": ";
	errorstream<<s<<"\n\n";
	
	logstream<<"Error at line "<<yylineno<<": ";
	logstream<<s<<"\n\n";
}

void yywarning(const string &s)
{

}

inline bool isTypeSpecifier(SymbolInfoPointer sip)
{
	if(sip == nullptr) return false;
	return sip->getTypeLocation()->getType() == "INT" or
			sip->getTypeLocation()->getType() == "FLOAT" or
			sip->getTypeLocation()->getType() == "VOID";
}

void logRule(string rule)
{
	logstream<<"Line "<<yylineno<<": "<<rule<<endl<<endl;
}

void print(SymbolInfoPointer sip , ostream & out = logstream)
{
	
	int padding=0;
	bool is_new_line = 1;
	int total_curl_brace = 0;
	int total_parentheses = 0;
	int last_for_parentheses = -1;
	while (sip)
	{

		string type = sip->getType().getType();

		if(type == "RCURL") padding-=2;

		if(is_new_line)	out<<string(padding , ' ');

		
		out<< sip->getName();
		//out<<"<"<<sip->getType()<<">";

		if(isTypeSpecifier(sip))
			out<<" ";
		else if(
			type == "RETURN" or
			type == "IF" or
			type == "WHILE" 
		)
			out<<" ";

		if(type == "LCURL") padding += 2;

		if(type == "LCURL") total_curl_brace++;
		if(type == "RCURL") total_curl_brace--;

		if(type == "LPAREN") total_parentheses++;
		if(type == "RPAREN") total_parentheses--;

		if(type == "FOR")
			last_for_parentheses = total_parentheses + 1;

		if(type == "SEMICOLON" or 
				type == "LCURL" or
					type == "RCURL" or
					type == "ELSE" )
		{
			if(type != "SEMICOLON" or total_parentheses != last_for_parentheses )
				out<<endl;

			if(type == "RCURL" and total_curl_brace == 0)
				out<<endl;

			is_new_line = 1;
		}
		else is_new_line = 0;
		
		sip = sip->getNextSymbolInfo();
	}
	//if(!is_new_line)
		out<<endl;
	out<<endl;
}


void add_func_parameters(SymbolInfoPointer parameters)
{
	lazy_parameters = parameters;
}


bool assignAbleType(string ltype, string rtype)
{
	if(ltype == rtype )
		return true;
	else if(ltype == "FLOAT" and rtype == "INT")
	{
		return true;
	}
	else if(ltype == "INT" and rtype == "FLOAT")
	{
		yyerror("Type Mismatch : FLOAT to INT " );
		return true;
	}
	else return false;
}

bool parseAbleArguments(Parameters lparam , Parameters rparam)
{
	if(lparam.size() != rparam.size())
		return false;
	for(int i=0;i<lparam.size();i++)
		if(assignAbleType(lparam[i] , rparam[i]) == false)
			return false;
	return true;
}

Parameters calcParametersFromParameterList(SymbolInfoPointer parameters)
{
// parameter_list  : parameter_list COMMA type_specifier ID
// 		| parameter_list COMMA type_specifier
// 		| type_specifier ID
// 		| type_specifier
// 		;
	Parameters ret;
	bool void_used = 0;;
	while (parameters)
	{
		if(isTypeSpecifier(parameters))
		{
			if(parameters ->getTypeLocation()->getType() == "VOID")
			{
				void_used = 1;
				//yyerror("Invalid use of type void in parameter declaration");
			}
			ret.push_back(parameters->getTypeLocation()->getType());
		}
		parameters = parameters->getNextSymbolInfo();
	}

	if(void_used and ret.size() > 1)
	{
		yyerror("'void' must be the only parameter");
	}
	else if(void_used)
		ret.clear();

	return ret;
}


void add_variable_declaration(SymbolInfoPointer sip)
{
	/// sip = var_declaration
	// var_declaration : type_specifier declaration_list SEMICOLON
	// 		;
	// type_specifier	: INT
	// 		| FLOAT
	// 		| VOID
	// 		;
	// declaration_list : declaration_list COMMA ID
	// 				| declaration_list COMMA ID LTHIRD CONST_INT RTHIRD
	// 				| ID
	// 				| ID LTHIRD CONST_INT RTHIRD
	// 				;	

	// ----- or ----
	// passed final parameter_list
	// parameter_list  : parameter_list COMMA type_specifier ID
	// 		| parameter_list COMMA type_specifier
	// 		| type_specifier ID
	// 		| type_specifier
	// 		;
	if(sip == 0) return ;

	string type_specifier ;
	bool used_type_specifier  = false ; 
	while (sip)
	{
		if(isTypeSpecifier(sip))
		{
			
			if(!type_specifier.empty() and used_type_specifier == false and type_specifier != "VOID")
			{
				yyerror("Variable name not found after type_specifier "+ type_specifier + " in function declaration");
			}

			type_specifier = sip->getType().getType();
			used_type_specifier = false;
		}
			
		
		if(sip->getType().getType() == "ID")
		{
			
			if(type_specifier.empty() or type_specifier == "VOID")
			{
				yyerror("Variable type cannot be "+type_specifier);
			}
			else 
			{
				SymbolInfoPointer new_symbol = new SymbolInfo<Info>(*sip);
				
				new_symbol->getTypeLocation()->setReturnType(type_specifier);
				used_type_specifier = true;
				
				if(sip->getNextSymbolInfo() and sip->getNextSymbolInfo()->getTypeLocation()->getType()=="LTHIRD")
					new_symbol->getTypeLocation()->setArray();

				bool inserted = symboltable->insert(new_symbol); //owner of new_symbol is symboltable
				if(!inserted)
				{
					yyerror("Multiple Declaration of "+ sip->getName());
				}
			}
		}
		sip = sip->getNextSymbolInfo();
	}

	if(!type_specifier.empty() and used_type_specifier == false and type_specifier != "VOID")
	{
		yyerror("Variable name not found after "+ type_specifier + " in function declaration");
	}
	
}


void add_func_declaration(SymbolInfoPointer returnType  , SymbolInfoPointer funcName ,SymbolInfoPointer parameters )
{

	Parameters parameterTypeList = calcParametersFromParameterList(parameters);
	
	SymbolInfoPointer ref = symboltable->lookUp(funcName->getName());
	if(ref == nullptr)
	{
		ref = new SymbolInfo<Info>(funcName);
		ref->getTypeLocation()->setParameters(parameterTypeList);
		ref->getTypeLocation()->setReturnType(returnType->getTypeLocation()->getType());
		ref->getTypeLocation()->setFunction();


		symboltable->insert(ref);
	}
	else 
	{
		if(ref->getTypeLocation()->isFunction() == false)
		{
			yyerror(funcName->getName() + " redeclared as different kind of entity");
		}
		else if(
			ref->getTypeLocation()->getParameters() != parameterTypeList 
		)
		{
			yyerror("Total number of arguments mismatch with declaration in function "+ funcName->getName());
		}
		else if(ref->getTypeLocation()->getReturnType() != returnType->getTypeLocation()->getType())
		{
			yyerror("Return type mismatch with function declaration in function "+funcName->getName());
		}
	}
	
}

void add_func_definition(SymbolInfoPointer returnType  , SymbolInfoPointer funcName ,SymbolInfoPointer parameters )
{
	add_func_declaration(returnType, funcName , parameters);
	add_func_parameters(parameters);
}



string getVariableType(string varName )
{
	SymbolInfoPointer sip = symboltable->lookUp(varName);
	if(sip == nullptr)
	{
		yyerror("Undeclared variable "+varName);
		return "VOID";
	}
	else if(sip->getTypeLocation()-> isArray())
	{
		yyerror("Type mismatch, "+varName+" is an array");
		return getReturnTypeFromSIP(sip);
	}
	else if(sip->getTypeLocation()-> isFunction())
	{
		yyerror("Parameters not used in Function : "+ varName);
		return "ERROR";
	}
	else 
	{
		return getReturnTypeFromSIP(sip);
	}
}
string getArrayType(string varName)
{
	SymbolInfoPointer sip = symboltable->lookUp(varName);
	if(sip == nullptr)
	{
		yyerror("Undeclared variable "+varName);
		return "VOID";
	}
	else if(sip->getTypeLocation()-> isArray())
		return getReturnTypeFromSIP(sip);
	else 
	{
		yyerror(varName + " not an array");
		return getReturnTypeFromSIP(sip);
	}
}


string getFuncReturnType(string funcName , SymbolInfoPointer argumentList)
{	
	// argument_list : arguments
	// 			|
	//			| error
	// 			;

	// arguments : arguments COMMA logic_expression
	// 		| logic_expression
	// 		| arguments error
	// 		| error logic_expression
	// 		;
	
	Parameters params=  argumentList ?  argumentList->getTypeLocation()->getParameters() : Parameters();


	SymbolInfoPointer ref = symboltable->lookUp(funcName);

	string type = "ERROR";

	if(ref == nullptr )
		yyerror("Undeclared function " + funcName);
	else if(ref->getTypeLocation()->isFunction() == false )
		yyerror("Not a Function: " + funcName);
	else if(ref->getTypeLocation()->getParameters().size() != params.size())
		yyerror("Total number of arguments mismatch in function "+funcName);
	else if(parseAbleArguments(ref->getTypeLocation()->getParameters()  , params) == false)
		yyerror("Invalid arguments for function call: " + funcName);
	
	if(ref != nullptr)
	type =  getReturnTypeFromSIP(ref);

	return type;
}

string combineArithmaticType(string type1 , string type2)
{
	if(type1 == "ERROR" or type2 == "ERROR")
		return "ERROR";
	else if(type1 == "VOID" or type2 == "VOID")
	{
		yyerror("Void statement used in expression");
		return "ERROR";
	}
	else if(type1 == "FLOAT" or type2 == "FLOAT")
		return "FLOAT";
	else return "INT";
}


void enterScope()
{
	symboltable->enterScope();
	add_variable_declaration(lazy_parameters);
	lazy_parameters = nullptr;
}

void exitScope()
{
	symboltable->printNonEmptyBuckets(logstream);
	symboltable->exitScope();
}


#endif