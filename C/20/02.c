#include "aoc.h"

int main () {
  I lo,hi,j,a=0,b=0;C c,p[20];
  while (EOF!=scanf("%lld-%lld %c: %s\n",&lo,&hi,&c,p))
    { DO(strlen(p)+(j=0),j+=p[i]==c);
      a += lo<=j && j<=hi;
      b += (p[lo-1]==c) ^ (p[hi-1]==c); }
  printf("part A: %lld\npart B: %lld\n",a,b); R 0;
}
