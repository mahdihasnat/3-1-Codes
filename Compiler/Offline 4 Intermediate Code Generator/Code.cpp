#include "Code.h"

Code * combine(Code *x,Code * y)
{
	if(x == nullptr)
		x=y;
	else
		x->append(y);
	return x;
}
