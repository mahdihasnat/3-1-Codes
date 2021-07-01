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
	Code * getNext()
	{
		return next_code;
	}
	string getOpcode()
	{
		if(code=="") return "";
		if(code[0] == ';') return ";";
		string ret = "";
		for(int i=0;i<code.size();i++)
		{
			if(code[i] == ' ') break;
			ret+=code[i];
		}
		return ret;
	}
	string getCode()
	{
		return code;
	}
	void setCode(string code)
	{
		this->code = code;
	}
	void removeSingleNext()
	{
		assert(next_code != nullptr);
		Code * new_next = next_code -> getNext();
		next_code = new_next;
	}
	void setNext(Code * newNext)
	{
		next_code = newNext;
	}

	Code * getLastRecursive()
	{
		if(next_code)
			last_code = next_code -> getLastRecursive();
		else
			last_code = this;
		
		return last_code;
	}
	void append(Code * new_next_code)
	{
		this->last_code->next_code = new_next_code;
		this->last_code = new_next_code->last_code;
	}
	void write(ostream &os, int indentation = 0)
	{
		os<<string(indentation , '\t')<<this->code<<"\n";
		if(this->code ==";>>")	indentation++;
		else if(this->code ==";<<")	indentation--;
		if(this->next_code)
		{
			return this->next_code->write(os ,indentation);
		}
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
Code * combine(Code *x,string instruction);
#endif 