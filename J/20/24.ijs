load '~/code/aoc/aoc.ijs'

V =: _2 ]\ 1 0  0 1  _1 1  _1 0  0 _1  1 _1
A =: +/@:(V{~(;:'e ne nw w sw se')i.(<;.2~ e.&'ew'))
+/ 2 | #/.~ in =: A;._2 aoc 2020 24

P =: (0&,@,&0)"1@:(0&,@,&0)
G =: 1 (<"1 G)}(1+>./G=.(-"1<./)in#~2|+/-:"1/~in)$0
+/,{{2=z+y*1=z=.+/V|.!.0"1 _ y=.P y}}^:100 G
