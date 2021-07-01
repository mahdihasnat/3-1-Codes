#include "Code.h"
map<string,Code * > labeledCode;

#include<bits/stdc++.h>
using namespace std;

std::vector<std::string> string_split(std::string s, const char delimiter)
{
    size_t start=0;
    size_t end=s.find_first_of(delimiter);
    
    std::vector<std::string> output;
    
    while (end <= std::string::npos)
    {
	    output.emplace_back(s.substr(start, end-start));

	    if (end == std::string::npos)
	    	break;

    	start=end+1;
    	end = s.find_first_of(delimiter, start);
    }
    
    return output;
}

bool endsWith(string s,string t)
{
	return s.size() >= t.size() and s.substr(int(s.size() - t.size()) ) == t;
}

void removeRedundantMove(Code * code)
{
	
	string x,y;
	while (code)
	{
		Code * nxt = code -> getNext();
		if(nxt == nullptr) break;
		

		string opNow = code -> getOpcode();
		string opNext = nxt -> getOpcode();

		if(opNow == ";") 
		{
			
		}
		else if(opNow == "MOV")
		{
			vector<string> vs = string_split(code -> getCode() , ' ' );
			if(vs.size() != 4)
			{
				x=y="";
			}
			else
			{
				x=vs[1];
				y=vs[3];
				// DBG(x);
				// DBG(y);
				// NL;
			}
		}
		else x=y="";
		
		if(opNext == "MOV")
		{
			vector<string> vs = string_split(nxt -> getCode() , ' ' );
			if(vs.size() != 4)
			{
				code = nxt;
			}
			else
			{
				string xx=vs[1];
				string yy=vs[3];

				if((xx == x and yy == y) or (xx == y and yy == x) )
				{
					// DBG(x);
					// DBG(y);
					// DBG(xx);
					// DBG(yy);
					// NL;
					code -> removeSingleNext();
				}
				else 
				{
					
					code = nxt;
				}
			}
		}
		else code = nxt;

	}
}

vector< string > profileCode(Code * code)
{
	
	// after .code section

	vector< string > ret;
	while(code)
	{
		
		if(endsWith(code -> getCode() , "PROC"))
		{
			string procName = code -> getOpcode();
			Code * begin_proc = code;
			ret.push_back(procName);
			
			labeledCode[procName]  = begin_proc;	
			
			code = code -> getNext();
		}
		else if(endsWith(code -> getCode() , "ENDP"))
		{
			Code * nxt = code -> getNext();
			code -> setNext(nullptr);
			code = nxt;
		}
		else if(endsWith(code -> getCode() , ":"))
		{
			string label = code->getCode();
			label = label.substr(0,label.size()-1);
			labeledCode[label]  = code;

			code = code -> getNext();
		}
		else code = code -> getNext();
	}
	return ret;
}

Code * getCodeSection(Code *code)
{
	while(code)
	{
		Code * nxt = code -> getNext();
		if(code -> getCode() == ".CODE")
		{
			code -> setNext(nullptr);
			return nxt;
		}
		code = nxt;
	}
	return nullptr;
}

void optimize(Code * fullCode )
{
	Code * codeSection = getCodeSection(fullCode);
	removeRedundantMove(codeSection);
	
	vector<string > procNames = profileCode(codeSection);

	fullCode->getLastRecursive();
	for(string procName : procNames)
	{
		Code * procCode = labeledCode [procName];
		procCode -> getLastRecursive();
		fullCode = combine(fullCode , procCode);
	}
	fullCode = combine(fullCode , "END main");
		
}
