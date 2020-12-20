load '~/code/aoc/aoc.ijs'

in =: aoc 2020 8
dp =: ({:"1) 0&".;._2 in
'acc nop jmp' =: (_3]\'accnopjmp') -:"1/ 3 {."1 ];._2 in
E =: (,#) ((+i.@#)jmp*dp)+1-jmp
tr =: {{ [: ~. ] , u {~ {: }}
+/ (dp*acc) {~ X =: (E tr^:_) 0

E1 =: (,#) ((+i.@#)nop*dp)+1-nop
j =: {. X #~ (X { E1) e. I. 649 = ({&E) ^: (<:#E) (i.@#) E
+/ (dp*acc) {~ }: ((E j}~ j{E1) tr^:_) 0
