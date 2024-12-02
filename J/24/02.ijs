load '~/code/aoc/aoc.ijs'
in =: <@". ;._2 aoc 2024 2
J =: */ @ (0&< * 4&>)        NB. safe jumps?
S =: (J@:- +. J) @ (2 -/\ ]) NB. overall safe?
+/ S &> in                   NB. part A
+/ ([: +./ 1 S \. ]) &> in   NB. part B
