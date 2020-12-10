#include "aoc.h"

#define N 1000

I X[N],M[N];

int main ()
{ I x,m=0,o=0,t=0; while (EOF!=scanf("%lld",&x)) {X[x]=1;m=MAX(m,x);}
  X[0]=1;X[m+3]=1; DO(m+1,o+=X[i]*X[i+1];t+=X[i]*(1-X[i+1])*(1-X[i+2])*X[i+3]);
  M[0]=1;M[1]=X[0];M[2]=M[0]+X[1]*M[1];
  DO(m+1,M[i+3]=X[i]*M[i]+X[i+1]*M[i+1]+X[i+2]*M[i+2]);
  printf("part A: %lld\npart B: %lld\n",o*t,M[m+3]); R 0; }
