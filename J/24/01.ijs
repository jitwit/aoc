load '~/code/aoc/aoc.ijs'
'A B' =: in =: |: ". ;._2 aoc 2024 1
+/ | -/ /:~"1 in      NB. part A
+/ A * +/ B =/ A      NB. part B
([:+/[*[:+/=/~)/ in   NB. tacit part B
