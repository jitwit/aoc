load '~/code/aoc/aoc.ijs regex'

NB. better than roots of unity for float reasons
V =: _2 ]\ 1 0 0 1 _1 1 _1 0 0 _1 1 _1
A =: +/@:(V{~(;:'e ne nw w sw se')i.'sw|nw|ne|se|e|w'&rxall)
+/ 2 | #/.~ in =: A;._2 aoc 2020 24 NB. part a

G =: 1 (<"1 G)}(1+>./G=.(-"1<./)in#~2|+/-:"1/~in)$0
+/,{{2=z+y*1=z=.+/V|.!.0"1 _/y=.0,~"1]0,"1]0,y,0}}^:100 G
