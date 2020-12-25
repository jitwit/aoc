load '~/code/aoc/aoc.ijs'

'a M b d' =: 7 20201227 , ".;._2 aoc 2020 25
A =: a M&|@^ i. m =: >. %: M
g =: a M&|@^ (M-1+m)
d M&|@^ m #. (A (i.~,i.) M|b*g M&|@^ i.m) -. m
