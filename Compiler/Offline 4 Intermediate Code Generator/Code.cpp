#include "Code.h"

Code * combine(Code *x,Code * y)
{
	if(x == nullptr)
		x=y;
	else if(y !=  nullptr)
		x->append(y);
	return x;
}

Code * combine(Code *x,string instruction)
{
	Code * y = new Code(instruction);
	return combine(x,y);
}