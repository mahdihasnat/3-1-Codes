#ifndef RETURNTYPEADDED
#define RETURNTYPEADDED

enum ReturnType
{
	Int,
	Float,
	Void,
	Error
};


ReturnType StringToReturnType(string s);
string to_string(ReturnType r);

#endif