load'~/code/aoc/aoc.ijs'
E =: (,|."2) {{];._1'-',y}};._2 aoc 2024 23
V =: /:~ ~. ,/ E
G =: 1 (<"1 V i. E)} 0$~,~#V NB. adjacency matrix
adj =: I. @ {&G              NB. adjacency list for y
A =: {{ t=.0 3$''            NB. find triangles starting with y
        for_a. I.y={."1 V do. for_b. adj a do. for_c. adj b do.
         if. G{~<c,a do. t=.t,/:~a,b,c end. end. end. end.
	#~.t }}
A 't'                        NB. part A
C =: {{ c=.,y                NB. find clique containing y
        for_a. adj y do. if. *./G{~<"1 a,.c do. c=.c,a end. end.
	< c }}
}.,',',.V{~cs{::~(i.>./)#&>cs=.C"0 i.#V
