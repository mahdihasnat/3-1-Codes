#ifndef ADDED_INFO
#define ADDED_INFO

#include <bits/stdc++.h>
using namespace std;

#include "ReutrnType.h"
#include "Code.h"
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

class Info
{
private:
	string type;
	Parameters parameters;
	bool is_func = false;
	bool is_array = false;
	ReturnType returnType;

	Code * code;
	int basedIndex ;
public:
	Info(string type) : type(type),code(0),basedIndex(-1)
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
	void setBasedIndex(int basedIndex)
	{
		this->basedIndex = basedIndex;
	}
	int getBasedIndex()
	{
		return this->basedIndex;
	}
	void setCode(Code * code)
	{
		this->code = code;
	}
	Code * getCode()
	{
		return this->code;
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
		os<<"{disp = "<<i.basedIndex<<"}";
		return os;
	}
};

#endif
