load '~/code/aoc/aoc.ijs'

in =: aoc 2020 8
jmp =: ({:"1) 0&".;._2 in
mem =: 3 {."1 ];._2 in
msk =: mem e. _3 ]\ 'accnop'
msk1 =: mem e. _3 ]\ 'accjmp'
E =: (,#) (([*[+i.@#) msk) + ((+i.@#) jmp)*-. msk
E1 =: (,#) (([*[+i.@#) msk1) + ((+i.@#) jmp)*-. msk1
step =: ~. @: (] , [ {~ {:@])

NB. part A
+/ jmp {~ IX #~ 'acc' -:"1 (IX =: E step ^: _ ] 0) { mem

G =: 1 (<"1 (,.~ i.@#) E)} (0$~,~1+#E)
X =: /:~ (#~ (~: i.@#)) 0 bfs G
Y =: I. 649 = ({&E) ^: (1+#E) (i.@#) E

j =: X #~ (X { E1) e. Y
NB. part B
+/ jmp {~ IX #~ 'acc' -:"1 (IX =: }: ((j{E1)j}E) step ^: _ ] 0) { mem
