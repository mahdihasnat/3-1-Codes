#ifndef ADDED_PARSERFUNCTIONS
#define ADDED_PARSERFUNCTIONS

#include<bits/stdc++.h>
using namespace std;

#include "Info.h"
#include "SymbolTable.h"

#define DBG(a) cerr<< "line "<<__LINE__ <<" : "<< #a <<" --> "<<(a)<<endl
#define NL cerr<<endl


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
	cout<<s<<"\n";
	errorstream<<"Error at Line "<<yylineno<<": ";
	errorstream<<s<<"\n\n";
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

void print(SymbolInfoPointer sip , ostream & out = logstream)
{
	out<<endl;
	int padding=0;
	bool is_new_line = 1;
	while (sip)
	{
		
		if(sip->getType().getType() == "RCURL") padding-=2;

		if(is_new_line)	out<<string(padding , ' ');

		
		out<< sip->getName();

		if(isTypeSpecifier(sip))
			out<<"  ";
		else if(
			sip->getType().getType() == "RETURN" 
		)
			out<<" ";


		if(sip->getType().getType() == "LCURL") padding += 2;

		if(sip->getType().getType() == "SEMICOLON" or 
				sip->getType().getType() == "LCURL" or
					sip->getType().getType() == "RCURL" )
		{
			out<<endl;
			is_new_line = 1;
		}
		else is_new_line = 0;
		
		sip = sip->getNextSymbolInfo();
	}
	if(!is_new_line)
		out<<endl;
}


void add_func_parameters(SymbolInfoPointer parameters)
{
	lazy_parameters = parameters;
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
				yyerror("Invalid type_specifier "+ type_specifier+" for variable "+ sip->getName());
			}
			else 
			{
				SymbolInfoPointer new_symbol = new SymbolInfo<Info>(*sip);
				
				new_symbol->getTypeLocation()->setReturnType(type_specifier);
				used_type_specifier = true;

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
		if(
			ref->getTypeLocation()->getParameters() != parameterTypeList or
		 ref->getTypeLocation()->getReturnType() != returnType->getTypeLocation()->getType()
		)
		{
			yyerror("Conflicting types for function: "+ funcName->getName());
		}
	}
	
}

void add_func_definition(SymbolInfoPointer returnType  , SymbolInfoPointer funcName ,SymbolInfoPointer parameters )
{
	add_func_declaration(returnType, funcName , parameters);
	add_func_parameters(parameters);
}



string getVariableType(string varName)
{
	SymbolInfoPointer sip = symboltable->lookUp(varName);
	if(sip == nullptr)
	{
		yyerror("Undeclared Variable: "+varName);
		return "VOID";
	}
	else 
	{
		return sip->getTypeLocation()->getReturnType();
	}
}

string getFuncType(string funcName , SymbolInfoPointer argumentList)
{	
	// argument_list : arguments
	// 			|
	// 			;

	// arguments : arguments COMMA logic_expression
	// 		| logic_expression
	// 		;
	
	return "NOTIMPL";
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