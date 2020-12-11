load '~/code/aoc/aoc.ijs'

]in =: =&'L';._2 aoc 2020 11
F =: (0=])`(4>])@.[ [: +/ (<:3 3#:(i.9)-.4)|.!.0/ ]
S =: in * ([: F 0&>.) &.: <: f.

+/ , 2 = S ^: _ in

pi =: /: ; </. i. $ in  NB. permutation for undoing obliques, based on input
A =: [`]@.(*@])         NB. janky accumulator to scan visible seats
H =: (_1 |.!.0 A/\) +&(=&2) 1 |.!.0 A~/\. NB. straight lines
D =: $ $ pi { [: ; <@H/.                  NB. diagonals
G =: (0=])`(5>])@.(2=[) H"1+H+D+D&.|.     NB. rules by visible chairs
T =: in * [: >: G f.

+/ , 2 = T ^: _ in
