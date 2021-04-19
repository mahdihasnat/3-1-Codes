#ifndef ADDED_INFO
#define ADDED_INFO

#include<bits/stdc++.h>
using namespace std;

typedef pair<string,string> pss;

typedef vector<pss> Parameters;

#define SymbolInfoPointer SymbolInfo<Info>*

class Info
{
private:
	string type ;
	Parameters parameters;
	bool is_func = 0;
public:
	Info( string type) : type(type)
	{
			
	}
	
	~Info()
	{

	}

	friend ostream & operator <<(ostream & os ,const Info & i)
	{
		os<<i.type;
		if(i.is_func)
		{
			os<<"(";
			for(pss x: i.parameters)
				os<<" ,"<<x.first<<" "<<x.second;
			os<<")";
		}
		return os;
	}
};

#endif
