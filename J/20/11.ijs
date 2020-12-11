load '~/code/aoc/aoc.ijs'

]in =: =&'L';._2 aoc 2020 11
F =: {{ y ((0=])`(4>])@.[) +/ (<:3 3 #: (i.9)-.4)|.!.0/ y }}
S =: in * (([: F 0&>.) &.: <:) f.
+/ , 2 = S ^: _ in

pi =: ; </. i. $ in  NB. permutation for undoing obliques, based on input
E1 =: ]`[@.(*@[)     NB. janky accumulators for scanning visible seats
E2 =: [`]@.(*@])
H =: (_1 |.!.0 E2/\) +&(0>.<:) (1 |.!.0 E1/\.) NB. straight lines
D =: $ $ pi /:~ [: ; ([:< H)/.                 NB. diagonals
G =: ((0=])`(5>])@.(0>.<:@:[)) H"1+H+D+(D&.|.) NB. rules by visible chairs
T =: in * [: >: G f.

+/ , 2 = T ^: _ in
