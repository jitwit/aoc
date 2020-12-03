#include "advent.h"

int main () {
  I X[200],*p=X,i,j,k,n=0,a=-1,b=-1;
  while (EOF!=scanf("%lld\n",p++)) n++;
  for(i=0;i<n;i++)
    for(j=i+1;j<n;j++)
      if(X[i]+X[j]==2020)
	{ a=X[i]*X[j]; goto partb; }
 partb:
  for(i=0;i<n;i++)
    for(j=i+1;j<n;j++)
      for(k=j+1;k<n;k++)
	if(X[i]+X[j]+X[k]==2020)
	  { b=X[i]*X[j]*X[k]; goto end; }
 end:
  printf("part A: %lld\npart B: %lld\n",a,b); R 0;
}
