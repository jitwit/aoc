load '~/code/aoc/aoc.ijs'

in =: aoc 2020 8
dp =: ({:"1) 0&".;._2 in
'acc nop jmp' =: (i.3) =/ mem =: (_3]\'accnopjmp') i. 3 {."1 ];._2 in
E =: (,#) ((+i.@#)jmp*dp)+1-jmp
G =: 1 (<"1 (,.~ i.@#) E)} (0$~,~#E)
NB. part A
+/ dp {~ 0,I.acc*}: (~:i.@#) 0 bfs G

E1 =: (,#) ((+i.@#)nop*dp)+1-nop
X =: /:~ (#~ (~: i.@#)) 0 bfs G
Y =: I. 649 = ({&E) ^: (1+#E) (i.@#) E
j =: {. X #~ (X { E1) e. Y

NB. part B
+/ dp {~ 0,I.acc*}: (~:i.@#) 0 bfs ((j{E1) = (i.#G)) j} G
