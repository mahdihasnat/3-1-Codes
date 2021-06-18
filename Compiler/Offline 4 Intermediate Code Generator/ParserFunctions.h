#ifndef ADDED_PARSERFUNCTIONS
#define ADDED_PARSERFUNCTIONS

#include <bits/stdc++.h>
using namespace std;

#include "Info.h"
#include "SymbolTable.h"
#include "ReutrnType.h"

#define DBG(a) cerr << "line " << __LINE__ << " : " << #a << " --> " << (a) << endl
#define NL cerr << endl

#define getReturnTypeFromSIP(sip) sip->getTypeLocation()->getReturnType()

extern int yylineno;
extern char *yytext;
extern int error_count;
extern SymbolTable<Info> *symboltable;
extern vector<pair<string, int>> globals;

extern ofstream logstream;
extern ofstream errorstream;

SymbolInfoPointer lazy_parameters;

void yyerror(const string &s)
{
	error_count++;

	errorstream << "Error at line " << yylineno << ": ";
	errorstream << s << "\n\n";

	logstream << "Error at line " << yylineno << ": ";
	logstream << s << "\n\n";
}

bool noerror()
{
	return error_count == 0;
}

void yywarning(const string &s)
{
}

string Comment(string comment)
{
	return ";Line " + to_string(yylineno) + ": " + comment;
}
int counter = 0;
string newLabel(string prefix)
{
	return prefix + "_" + to_string(counter++);
}
int newLabelCounter()
{
	return counter++;
}

Code *loadLibrary()
{
	string fileName = "println.asm";
	Code *code = nullptr;
	ifstream in(fileName);
	string line;

	while (getline(in, line))
	{
		code = combine(code, line);
	}
	return code;
}

inline bool isTypeSpecifier(SymbolInfoPointer sip)
{
	if (sip == nullptr)
		return false;
	return sip->getTypeLocation()->getType() == "INT" or
		   sip->getTypeLocation()->getType() == "FLOAT" or
		   sip->getTypeLocation()->getType() == "VOID";
}

void logRule(string rule)
{
	logstream << "Line " << yylineno << ": " << rule << endl
			  << endl;
}

void print(SymbolInfoPointer sip, ostream &out = logstream)
{

	int padding = 0;
	bool is_new_line = 1;
	int total_curl_brace = 0;
	int total_parentheses = 0;
	int last_for_parentheses = -1;
	while (sip)
	{

		string type = sip->getType().getType();

		if (type == "RCURL")
			padding -= 2;

		if (is_new_line)
			out << string(padding, ' ');

		out << sip->getName();
		//out<<"<"<<sip->getType()<<">";

		if (isTypeSpecifier(sip))
			out << " ";
		else if (
			type == "RETURN" or
			type == "IF" or
			type == "WHILE")
			out << " ";

		if (type == "LCURL")
			padding += 2;

		if (type == "LCURL")
			total_curl_brace++;
		if (type == "RCURL")
			total_curl_brace--;

		if (type == "LPAREN")
			total_parentheses++;
		if (type == "RPAREN")
			total_parentheses--;

		if (type == "FOR")
			last_for_parentheses = total_parentheses + 1;

		if (type == "SEMICOLON" or
			type == "LCURL" or
			type == "RCURL" or
			type == "ELSE")
		{
			if (type != "SEMICOLON" or total_parentheses != last_for_parentheses)
				out << endl;

			if (type == "RCURL" and total_curl_brace == 0)
				out << endl;

			is_new_line = 1;
		}
		else
			is_new_line = 0;

		sip = sip->getNextSymbolInfo();
	}
	//if(!is_new_line)
	out << endl;
	out << endl;
}

void add_func_parameters(SymbolInfoPointer parameters)
{
	lazy_parameters = parameters;
}

bool assignAbleType(ReturnType ltype, ReturnType rtype)
{
	if (ltype == rtype)
		return true;
	else if (ltype == Float and rtype == Int)
	{
		return true;
	}
	else if (ltype == Int and rtype == Float)
	{
		yyerror("Type Mismatch : FLOAT to INT ");
		return true;
	}
	else
		return false;
}

bool parseAbleArguments(Parameters lparam, Parameters rparam)
{
	if (lparam.size() != rparam.size())
		return false;
	for (int i = 0; i < lparam.size(); i++)
		if (assignAbleType(lparam[i], rparam[i]) == false)
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
	bool void_used = 0;
	;
	while (parameters)
	{
		if (isTypeSpecifier(parameters))
		{
			if (parameters->getTypeLocation()->getType() == "VOID")
			{
				void_used = 1;
				//yyerror("Invalid use of type void in parameter declaration");
			}
			ret.push_back(StringToReturnType(parameters->getTypeLocation()->getType()));
		}
		parameters = parameters->getNextSymbolInfo();
	}

	if (void_used and ret.size() > 1)
	{
		yyerror("'void' must be the only parameter");
	}
	else if (void_used)
		ret.clear();

	return ret;
}

string getSingleVariableAddress(SymbolInfoPointer ref)
{
	int idx = ref->getTypeLocation()->getBasedIndex();
	if (idx == -1)
	{
		return ref->getName();
	}
	else
	{
		return to_string(idx) + "[BP]";
	}
}

Code *loopImplementation(
	Code *code_init,
	Code *code_check,
	Code *code_step,
	Code *code_statement)
{
	string label_loop = newLabel("for_body");
	string label_end = newLabel("for_end");

	// init
	// loop:
	// 		check
	// 		statement
	// 		step
	//		goto loop

	Code *code = nullptr;
	code = combine(code, Comment("start of for loop"));

	code = combine(code, code_init);
	code = combine(code, label_loop + ":");
	code = combine(code, ";>>");
	code = combine(code, code_check);
	code = combine(code, "CMP DX , 0");
	code = combine(code, "JZ " + label_end);
	code = combine(code, ";>>");
	code = combine(code, Comment("start of for loop statement"));
	code = combine(code, code_statement);
	code = combine(code, ";<<");
	code = combine(code, Comment("start of for loop step"));
	code = combine(code, code_step);

	code = combine(code, "JMP " + label_loop);

	code = combine(code, ";<<");
	code = combine(code, label_end + ":");

	return code;
}

Code *conditionImplementation(Code *expression, Code *true_statement, Code *false_statement)
{
	// expr
	// if false go false_statement
	// true_statement
	// jmp end
	// false_statement
	// end

	int suffix_counter = newLabelCounter();
	string label_false = "if_false" +to_string(suffix_counter);
	string label_end = "if_end" +to_string(suffix_counter);

	Code *code = nullptr;
	code = combine(code, expression);
	code = combine(code, "CMP DX , 0");
	code = combine(code, "JZ "+label_false);
	code = combine(code , ";>>");
		code = combine(code, true_statement);
		code = combine(code, "JMP "+label_end);
	code = combine(code , ";<<");
	code = combine(code, label_false+":");
	code = combine(code , ";>>");
		code = combine(code, false_statement);
	code = combine(code , ";<<");
	code = combine(code, label_end+":");

	return code;
}

Code *writeToVariable(SymbolInfoPointer sip, Code *value)
{
	// variable : ID
	//  		| ID LTHIRD expression RTHIRD
	//  		;
	// value must be is stack safe ,
	// means push value pop wont cause any harm on symboltable reference
	// means no variable declaration in value
	// for array id[expr] = value : expr is evaluated first then value then mov

	assert(noerror());
	Code *code = nullptr;

	string var_name = sip->getName();
	SymbolInfoPointer ref = symboltable->lookUp(var_name);
	assert(ref);

	if (ref->getTypeLocation()->isArray())
	{

		SymbolInfoPointer expr = sip->getNextSymbolInfo()->getNextSymbolInfo();

		code = combine(
			code,
			expr->getTypeLocation()->getCode() /// dx e expr ache
		);

		code = combine(code, "PUSH DX");
		code = combine(
			code,
			value);
		code = combine(code, "POP AX");
		// ax -> index , dx -> value
		code = combine(code, "XCHG AX ,DX");
		// dx -> index , ax -> value

		int idx = ref->getTypeLocation()->getBasedIndex();

		if (idx == -1)
		{
			code = combine(code, Comment("set  element to memory array"));
			code = combine(code, "SAL DX , 1");
			code = combine(code, "MOV BX , DX");
			code = combine(code, "MOV PTR WORD " + var_name + "[BX] , AX");
			code = combine(code, "MOV DX , AX");
		}
		else
		{
			code = combine(code, Comment("put element to stack array"));
			code = combine(code, "PUSH BP");
			code = combine(code, "SAL DX , 1");
			code = combine(code, "ADD DX , " + to_string(idx));
			code = combine(code, "ADD BP , DX");
			code = combine(code, "MOV PTR WORD [BP] , AX");
			code = combine(code, "MOV DX , AX");
			code = combine(code, "POP BP");
		}
	}
	else
	{
		code = combine(code, value);
		code = combine(code, "MOV " + getSingleVariableAddress(ref) + " , DX");
	}
	return code;
}

void readFromVariable(SymbolInfoPointer sip)
{
	// variable : ID
	//  		| ID LTHIRD expression RTHIRD
	//  		;
	assert(noerror());
	string var_name = sip->getName();
	SymbolInfoPointer ref = symboltable->lookUp(var_name);
	assert(ref);
	if (ref->getTypeLocation()->isArray())
	{
		SymbolInfoPointer expr = sip->getNextSymbolInfo()->getNextSymbolInfo();

		Code *code = expr->getTypeLocation()->getCode(); /// dx e expr ache

		int idx = ref->getTypeLocation()->getBasedIndex();

		if (idx == -1)
		{
			code = combine(code, Comment("get array element from memory"));
			code = combine(code, "SAL DX , 1");
			code = combine(code, "MOV BX , DX");
			code = combine(code, "MOV DX , PTR WORD " + var_name + "[BX]");
		}
		else
		{
			code = combine(code, Comment("get array element from stack"));
			code = combine(code, "PUSH BP");
			code = combine(code, "SAL DX , 1");
			code = combine(code, "ADD DX , " + to_string(idx));
			code = combine(code, "ADD BP , DX");
			code = combine(code, "MOV DX , PTR WORD [BP]");
			code = combine(code, "POP BP");
		}

		sip->getTypeLocation()->setCode(code);
	}
	else
	{
		sip->getTypeLocation()->setCode(
			new Code("MOV DX , " + getSingleVariableAddress(ref)));
	}
}

Code *add_variable_declaration(SymbolInfoPointer sip, bool is_from_function = false)
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

	Code *code = nullptr;

	if (sip == 0)
		return code;

	ReturnType type_specifier = Error;
	bool used_type_specifier = false;

	int current_base_pointer = is_from_function ? 4 : symboltable->getBaseIndex(); /// need to correct for non function

	while (sip)
	{
		if (isTypeSpecifier(sip))
		{

			if (type_specifier != Error and used_type_specifier == false and type_specifier != Void)
			{
				yyerror("Variable name not found after type_specifier " + to_string(type_specifier) + " in function declaration");
			}

			type_specifier = StringToReturnType(sip->getType().getType());
			used_type_specifier = false;
		}

		if (sip->getType().getType() == "ID")
		{

			if (type_specifier == Error or type_specifier == Void)
			{
				yyerror("Variable type cannot be " + to_string(type_specifier));
			}
			else
			{
				SymbolInfoPointer new_symbol = new SymbolInfo<Info>(*sip);

				new_symbol->getTypeLocation()->setReturnType(type_specifier);
				used_type_specifier = true;

				int var_size = 1;

				if (sip->getNextSymbolInfo() and sip->getNextSymbolInfo()->getTypeLocation()->getType() == "LTHIRD")
				{
					new_symbol->getTypeLocation()->setArray();
					string const_int_str = sip->getNextSymbolInfo()->getNextSymbolInfo()->getName();
					var_size = stoi(const_int_str);
				}

				bool inserted = symboltable->insert(new_symbol); //owner of new_symbol is symboltable
				if (!inserted)
				{
					yyerror("Multiple Declaration of " + sip->getName());
				}
				else if (noerror())
				{
					if (symboltable->isGlobalScope())
					{
						globals.push_back(make_pair(sip->getName(), var_size));
					}
					else if (is_from_function)
					{
						new_symbol->getTypeLocation()->setBasedIndex(current_base_pointer);
						current_base_pointer += var_size * 2;
					}
					else
					{

						code = combine(code, new Code("SUB SP , " + to_string(var_size * 2)));
						symboltable->addBaseIndex(var_size * -2);
						new_symbol->getTypeLocation()->setBasedIndex(symboltable->getBaseIndex());
					}
				}
			}
		}
		sip = sip->getNextSymbolInfo();
	}

	if (type_specifier != Error and used_type_specifier == false and type_specifier != Void)
	{
		yyerror("Variable name not found after " + to_string(type_specifier) + " in function declaration");
	}

	return code;
}

void add_func_declaration(SymbolInfoPointer returnType, SymbolInfoPointer funcName, SymbolInfoPointer parameters)
{

	Parameters parameterTypeList = calcParametersFromParameterList(parameters);

	SymbolInfoPointer ref = symboltable->lookUp(funcName->getName());
	if (ref == nullptr)
	{
		ref = new SymbolInfo<Info>(funcName);
		ref->getTypeLocation()->setParameters(parameterTypeList);
		ref->getTypeLocation()->setReturnType(StringToReturnType(returnType->getTypeLocation()->getType()));
		ref->getTypeLocation()->setFunction();

		symboltable->insert(ref);
	}
	else
	{
		if (ref->getTypeLocation()->isFunction() == false)
		{
			yyerror(funcName->getName() + " redeclared as different kind of entity");
		}
		else if (
			ref->getTypeLocation()->getParameters() != parameterTypeList)
		{
			yyerror("Total number of arguments mismatch with declaration in function " + funcName->getName());
		}
		else if (ref->getTypeLocation()->getReturnType() != StringToReturnType(returnType->getTypeLocation()->getType()))
		{
			yyerror("Return type mismatch with function declaration in function " + funcName->getName());
		}
	}
}

void add_func_definition(SymbolInfoPointer returnType, SymbolInfoPointer funcName, SymbolInfoPointer parameters)
{
	add_func_declaration(returnType, funcName, parameters);
	add_func_parameters(parameters);
}

ReturnType getVariableType(string varName)
{
	SymbolInfoPointer ref = symboltable->lookUp(varName);
	if (ref == nullptr)
	{
		yyerror("Undeclared variable " + varName);
		return Error;
	}
	else if (ref->getTypeLocation()->isArray())
	{
		yyerror("Type mismatch, " + varName + " is an array");
		return getReturnTypeFromSIP(ref);
	}
	else if (ref->getTypeLocation()->isFunction())
	{
		yyerror("Parameters not used in Function : " + varName);
		return Error;
	}
	else
	{
		return getReturnTypeFromSIP(ref);
	}
}
ReturnType getArrayType(string varName)
{
	SymbolInfoPointer sip = symboltable->lookUp(varName);
	if (sip == nullptr)
	{
		yyerror("Undeclared variable " + varName);
		return Error;
	}
	else if (sip->getTypeLocation()->isArray())
		return getReturnTypeFromSIP(sip);
	else
	{
		yyerror(varName + " not an array");
		return getReturnTypeFromSIP(sip);
	}
}

ReturnType getFuncReturnType(string funcName, SymbolInfoPointer argumentList)
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

	Parameters params = argumentList ? argumentList->getTypeLocation()->getParameters() : Parameters();

	SymbolInfoPointer ref = symboltable->lookUp(funcName);

	ReturnType type = Error;

	if (ref == nullptr)
		yyerror("Undeclared function " + funcName);
	else if (ref->getTypeLocation()->isFunction() == false)
		yyerror("Not a Function: " + funcName);
	else if (ref->getTypeLocation()->getParameters().size() != params.size())
		yyerror("Total number of arguments mismatch in function " + funcName);
	else if (parseAbleArguments(ref->getTypeLocation()->getParameters(), params) == false)
		yyerror("Invalid arguments for function call: " + funcName);

	if (ref != nullptr)
		type = getReturnTypeFromSIP(ref);

	return type;
}

ReturnType combineArithmaticType(ReturnType type1, ReturnType type2)
{
	if (type1 == Error or type2 == Error)
		return Error;
	else if (type1 == Void or type2 == Void)
	{
		yyerror("Void statement used in expression");
		return Error;
	}
	else if (type1 == Float or type2 == Float)
		return Float;
	else
		return Int;
}

Code *enterScope()
{
	symboltable->enterScope();
	Code *code = add_variable_declaration(lazy_parameters, true);
	lazy_parameters = nullptr;
	return code;
}

Code *exitScope()
{
	Code *code = nullptr;
	symboltable->printNonEmptyBuckets(logstream);
	int size = symboltable->currentDataSize();
	if (size > 0)
		code = new Code("ADD SP , " + to_string(size));

	symboltable->exitScope();

	return code;
}

bool isZero(const string &s)
{
	for (const char &c : s)
		if (c != '0' and c != '.')
			return 0;
	return 1;
}

#endif