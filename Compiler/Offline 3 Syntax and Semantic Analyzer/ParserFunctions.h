#ifndef ADDED_PARSERFUNCTIONS
#define ADDED_PARSERFUNCTIONS

#include<bits/stdc++.h>
using namespace std;

#include "Info.h"
#include "SymbolTable.h"

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
	
	errorstream<<"Error at Line "<<yylineno<<": ";
	errorstream<<s<<"\n\n";
}

void print(SymbolInfoPointer sip)
{
	logstream<<endl;
	int padding=0;
	bool is_new_line = 1;
	while (sip)
	{
		
		if(sip->getType().getType() == "RCURL") padding-=2;

		if(is_new_line)	logstream<<string(padding , ' ');

		
		logstream<< sip->getName();

		if(sip->getType().getType() == "INT" or 
			sip->getType().getType() == "FLOAT" or 
			sip->getType().getType() == "DOUBLE" or 
			sip->getType().getType() == "VOID" 
		)
			logstream<<"  ";
		else if(
			sip->getType().getType() == "RETURN" 
		)
			logstream<<" ";


		if(sip->getType().getType() == "LCURL") padding += 2;

		if(sip->getType().getType() == "SEMICOLON" or 
				sip->getType().getType() == "LCURL" or
					sip->getType().getType() == "RCURL" )
		{
			logstream<<endl;
			is_new_line = 1;
		}
		else is_new_line = 0;
		
		sip = sip->getNextSymbolInfo();
	}
	if(!is_new_line)
		logstream<<endl;
}


void add_func_parameters(SymbolInfoPointer parameters)
{
	lazy_parameters = parameters;
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
	sip = sip->getNextSymbolInfo();
	while (sip)
	{
		if(sip->getType().getType() == "ID")
		{
			
			SymbolInfoPointer new_symbol = new SymbolInfo<Info>(*sip);

			bool inserted = symboltable->insert(new_symbol); //owner of new_symbol is symboltable
			if(!inserted)
			{
				yyerror("Multiple Declaration of "+ sip->getName());
			}
		}
		sip = sip->getNextSymbolInfo();
	}
	
}

void add_func_definition(SymbolInfoPointer returnType  , SymbolInfoPointer funcName ,SymbolInfoPointer parameters )
{
	///todo: check consistency

	symboltable->insert(new SymbolInfo<Info>(funcName));
	add_func_parameters(parameters);
}

void add_func_declaration(SymbolInfoPointer returnType  , SymbolInfoPointer funcName ,SymbolInfoPointer parameters )
{
	/// todo: check consistency
	symboltable->insert(new SymbolInfo<Info>(funcName));
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