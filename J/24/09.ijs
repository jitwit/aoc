load '~/code/aoc/aoc.ijs'
in =: "."0 LF-.~aoc 2024 9
M =: ;,{{(a$c);(b$_1)['a b c'=.y}}"1 (,.i.@#) _2 ]\ in
n =: +/ E =: _1=M
D =: (-n)}.(|.(-n){.M-._1) (I.E)}M
+/(*i.@#) D
NB. use heap for part 2 in scheme?
