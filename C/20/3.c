#include "aoc.h"
#define H 323
#define W 31
C T[H][W];

I ski (I dx, I dy)
{ I t=0;DO(H/dy,t+='#'==T[i*dy][i*dx%W]);R t; }

int main ()
{ C*p=(C*)T;
  while (EOF!=scanf("%s\n",p)) p+=W;
  printf("part A: %lld\n",ski(3,1));
  printf("part B: %lld\n",ski(1,1)*ski(3,1)*ski(5,1)*ski(7,1)*ski(1,2));
  R 0; }
