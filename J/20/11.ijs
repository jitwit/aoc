load '~/code/aoc/aoc.ijs'

]in =: =&'L';._2 aoc 2020 11
F =: (0=])`(4>])@.[ [: +/ (<:3 3#:(i.9)-.4)|.!.0/ ]
S =: in * 1 + F @: (2&=) f.

+/ , 2 = S ^: _ in

pi =: /: ; </. i. $ in                   NB. permutation based on razed obliques
A =: [`]@.(*@])                          NB. janky accumulator for visible seats
H =: (_1 |.!.0 A/\) +&(=&2) 1|.!.0 A~/\. NB. straight lines
D =: $ $ pi { [: ; <@H/.                 NB. diagonals
G =: (0=])`(5>])@.(2=[) H"1+H+D+D&.|.    NB. rules by visible chairs
T =: in * 1 + G f.

+/ , 2 = T ^: _ in
