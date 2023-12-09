load '~/code/aoc/aoc.ijs'
in =: {{".'_'(I.'-'=y)}y}};._2 aoc 2023 9
NB. fit: n points, match to polynomial of degree n-1
+/ (# p.~ (%.(^/~)@i.@#)@x:)"1 in0
+/ (_1 p.~ (%.(^/~)@i.@#)@x:)"1 in0
