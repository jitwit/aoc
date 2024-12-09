load '~/code/aoc/aoc.ijs'
in =: LF-.~aoc 2024 9

in =: "."0 in
]M =: ;,{{(a$c);(b$_1)['a b c'=.y}}"1 (,.i.@#) _2 ]\ in
n =: +/ E =: _1=M
D =: x: (-n)}.(|.(-n){.M-._1) (I.E)}M
+/(*i.@#) D
