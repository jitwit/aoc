#include "advent.h"

int main () {
  I X[200],*p=X,i,j,k,n=0,a=-1,b=-1;
  while (1==scanf("%lld\n",p++)) n++;
  for(i=0;i<n-1;i++)
    for(j=i+1;j<n;j++)
      if(X[i]+X[j]==2020)
	{ a=X[i]*X[j]; goto partb; }
 partb:
  for(i=0;i<n-2;i++)
    for(j=i+1;j<n-1;j++)
      for(k=j+1;k<n;k++)
	if(X[i]+X[j]+X[k]==2020)
	  { b=X[i]*X[j]*X[k]; goto end; }
 end:
  R printf("part A: %lld\npart B: %lld\n",a,b);
}
