load '~/code/aoc/aoc.ijs'
in =: <@". ;._2 aoc 2024 2
M =: */ @ (={.) @: *         NB. monotone sequence?
J =: */ @ (0 < 4 > |)        NB. jumps safe?
S =: (J * M) @ (2 -/\ ])     NB. overall safe?
+/ S &> in                   NB. part A
+/ ([: +./ 1 S \. ]) &> in   NB. part B
