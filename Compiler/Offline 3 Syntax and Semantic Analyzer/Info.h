#ifndef ADDED_INFO
#define ADDED_INFO

#include<bits/stdc++.h>
using namespace std;

//typedef pair<string,string> pss;

typedef vector<string> Parameters;

#define SymbolInfoPointer SymbolInfo<Info>*


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
	string type ;
	Parameters parameters;
	bool is_func = false;
	string returnType;
public:
	Info( string type) : type(type)
	{
			
	}
	string getType()
	{
		return type;
	}
	string getReturnType()
	{
		return returnType;
	}
	void setReturnType(string returnType)
	{
		this->returnType=returnType;
	}

	void setParameters(Parameters parameters )
	{
		this->parameters = parameters;
	}
	Parameters getParameters()
	{
		return parameters;
	}
	void setFunction()
	{
		is_func = true;
	}
	
	~Info()
	{

	}

	friend ostream & operator <<(ostream & os ,const Info & i)
	{
		os<<i.returnType<<" ";
		os<<i.type;
		if(i.is_func)
		{
			os<<"(";
			for(auto x: i.parameters)
				os<<" ,"<<x;
			os<<")";
		}
		return os;
	}
};

#endif
