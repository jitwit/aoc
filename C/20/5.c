#include "aoc.h"

C B[10];I S[1024];

int main ()
{ I hi=-1,x;
  while (EOF!=scanf("%s",B))
    { x=0;DO(10,x*=2;x+=(B[i]=='B')+(B[i]=='R'));
      hi=MAX(hi,x);S[x]=1; }
  printf("Part A: %lld\n",hi);
  x=hi; while (S[x]) x--;
  printf("Part B: %lld\n",x);
  R 0; }
