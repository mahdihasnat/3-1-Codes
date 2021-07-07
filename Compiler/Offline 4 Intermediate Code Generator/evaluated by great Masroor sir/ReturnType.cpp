#include<bits/stdc++.h>
using namespace std;
#include "ReutrnType.h"

ReturnType StringToReturnType(string s)
{
	transform(s.begin(), s.end(), s.begin(), ::tolower);
	if (s == "error")
		return Error;
	else if (s == "int")
		return Int;
	else if (s == "float")
		return Float;
	else if (s == "void")
		return Void;
	else
		return Error;
}	
string to_string(ReturnType r)
{
	switch (r)
	{
	case Int:
		return "int";
	case Float:
		return "float";
	case Void:
		return "void";
	case Error:
		return "error";

	default:
		return "enum not found!";
	}
}

ostream & operator <<( ostream &os ,const ReturnType &r)
{
	return os<<to_string(r);
}