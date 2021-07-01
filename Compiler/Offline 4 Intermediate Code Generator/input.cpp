//  short circuit and 
// short circuit or

int one1(){float x ; x= 1.1;println(x);return 1;}
int one2(){float x ; x= 1.2;println(x);return 1;}
int one3(){float x ; x= 1.3;println(x);return 1;}
int zero1(){float x ; x= 0.1;println(x);return 0;}
int zero2(){float x ; x= 0.2;println(x);return 0;}
int zero3(){float x ; x= 0.3;println(x);return 0;}

void main()
{
	int del;
	del = 5;
	if(one1() && ( zero1() || one2() )) ; // 1.1 0.1 1.2
	println(del);// 5
	if(one1() || one2());// 1.10
	println(del);// 5
	if(zero1() || zero2()) ; // 0.1 0.2
	println(del);// 5
	if(zero1() || one2()) ; // 0.1 1.2
	println(del);// 5
	int i;
	for(i=0;i<5;i++)
	{
		println(i);
		int j;

		for(j=i+1;j<del;j++)
		{
			float x;
			x=i+j/10.0;
			println(x);
		}
	}
	

}	