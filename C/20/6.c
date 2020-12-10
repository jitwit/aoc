#include "aoc.h"
#define N 26
C B[N+1];I X[N],Y[N];

int main ()
{ I a=0,b=0,j;size_t m; C*l; DO(26,X[i]=0;Y[i]=1);
  while (EOF!=getline(&l,&m,stdin))
    { if(2>(j=strlen(l)))
	// { DO(N,printf("%lld\n",Y[i])); }
      	{ DO(N,a+=X[i]);
	  DO(N,b+=Y[i]);
	  
	} // ;X[i]=0;b+=Y[i];Y[i]=1); }
    }
  printf("Part A: %lld\n",a);
  printf("Part B: %lld\n",b);
  R 0; }
