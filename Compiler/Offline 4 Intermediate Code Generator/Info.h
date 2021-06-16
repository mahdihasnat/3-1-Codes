#ifndef ADDED_INFO
#define ADDED_INFO

#include <bits/stdc++.h>
using namespace std;

#include "ReutrnType.h"

//typedef pair<string,string> pss;

typedef vector<ReturnType> Parameters;

#define SymbolInfoPointer SymbolInfo<Info> *

// bool operator != (const Parameters &l, const Parameters & r)
// {
// 	if(l.size() != r.size())
// 		return 1;
// 	for(int i=0;i<l.size();i++)
// 		if(l[i]!= r[i])
// 			return 1;
// 	return 0;
// }
// bool operator == (const Parameters &l, const Parameters & r)
// {
// 	if(l.size() != r.size())
// 		return 0;
// 	for(int i=0;i<l.size();i++)
// 		if(l[i]!= r[i])
// 			return 0;
// 	return 1;
// }

class Code
{
private:
	string code;
	Code * next_code;
	Code * last_code;
public:
	Code(string code) : code(code) , next_code(nullptr) { last_code = this;}
	~Code()
	{
		if(next_code)
			delete next_code;
	}
	void append(Code * new_next_code)
	{
		this->last_code->next_code = new_next_code;
		this->last_code = new_next_code->last_code;
	}

};

class Info
{
private:
	string type;
	Parameters parameters;
	bool is_func = false;
	bool is_array = false;
	ReturnType returnType;

	Code * code;

public:
	Info(string type) : type(type)
	{
		returnType = Error;
	}
	string getType()
	{
		return type;
	}
	ReturnType getReturnType()
	{
		return returnType;
	}
	void setReturnType(ReturnType returnType)
	{
		this->returnType = returnType;
	}

	void setParameters(Parameters parameters)
	{
		this->parameters = parameters;
	}
	Parameters getParameters()
	{
		return parameters;
	}

	Parameters *getParametersLocation()
	{
		return &parameters;
	}

	bool isFunction()
	{
		return is_func;
	}

	void setFunction()
	{
		is_func = true;
	}

	bool isArray()
	{
		return is_array;
	}
	void setArray()
	{
		is_array = true;
	}

	~Info()
	{
	}

	friend ostream &operator<<(ostream &os, const Info &i)
	{
		// os<<i.returnType<<" ";
		os << i.type;
		// if(i.is_func)
		// {
		// 	os<<"(";
		// 	for(auto x: i.parameters)
		// 		os<<" ,"<<x;
		// 	os<<")";
		// }
		return os;
	}
};

#endif