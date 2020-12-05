#include "aoc.h"

C B[10];I S[1024];

int main ()
{ I lo=1024,hi=0,x;
  while (EOF!=scanf("%s",B))
    { x=0; DO(10,x*=2;x+=(B[i]=='B')+(B[i]=='R'));
      lo=MIN(lo,x);hi=MAX(hi,x);S[x]=1; }
  printf("Part A: %lld\n",hi);
  x=lo; while (S[x]) x++;
  printf("Part B: %lld\n",x);
  R 0; }
