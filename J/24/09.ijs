load '~/code/aoc/aoc.ijs'
in =: "."0 LF-.~aoc 2024 9
M =: ;,{{(a$c);(b$_1)['a b c'=.y}}"1 (,.i.@#) _2 ]\ in
D =: (-n)}.(|.(-n=:+/E){.M-._1) (I.E=:_1=M)}M
+/(*i.@#) D
