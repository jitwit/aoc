load '~/code/aoc/aoc.ijs'
+/ , 2 3 4 7 e.~ # &> _4 {."1 digs =: ;:;._2 aoc 2021 8 NB. part A
NB. can determine digit by length, intersection with 1 and intersection with 4
table =: _3 ]\ 6 2 3 2 2 2 5 1 2 5 2 3 4 2 4 5 1 3 6 1 3 3 2 2 7 2 4 6 2 4
phi =: {{ (#y),(+/ y e. m),(+/ y e. n) }}
decode =: {{ 'd1 d4' =: 0 2 { (/: #&>) ds =. 10 {. y
              10 #. table i. (d1 phi d4) &> _4 {. y }}
+/ decode"1 digs NB. part B
