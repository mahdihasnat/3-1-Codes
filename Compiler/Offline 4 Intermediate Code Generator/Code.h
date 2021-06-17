#ifndef ADDED_CODE
#define ADDED_CODE

#include<bits/stdc++.h>
using namespace std;

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

	friend ostream& operator<<(ostream &os,const Code & c)
	{
		os<<c.code<<"\n";
		if(c.next_code)
			os<<(*c.next_code);
		return os;
	}
};

Code * combine(Code *x,Code * y);

#endif 