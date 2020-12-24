load '~/code/aoc/aoc.ijs regex'

NB. better than roots of unity for float reasons
V =: _2 ]\ 1 0 0 1 _1 1 _1 0 0 _1 1 _1
A =: +/@:(V{~(;:'e ne nw w sw se')i.'sw|nw|ne|se|e|w'&rxall)
in =: A;._2 aoc 2020 24
+/ 2 | #/.~ in NB. part a
P =: {{for_d.i.s=.#$y do.y=.0,"(d+1)y,"(d+1),0 end.}}^:2
G =: 1 (<"1 G)}(1+>./G=.(-"1<./)in#~2|+/-:"1/~in)$0
life =: {{2=z+y*1=z=.+/V|.!.0"1 _/y=.P y}}
+/,life ^: 100 G NB. part B
