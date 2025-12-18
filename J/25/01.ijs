load'~/code/aoc/aoc.ijs'
in =: ];._2 aoc 2025 1
X =: ". }."1 in
S =: _1 1 {~ 'LR' i. {."1 in
+/ 0 = 100 | 50 + +/\ S*X

eg =: 0 : 0
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
)


in =: ];._2 eg
X =: ". }."1 in
S =: _1 1 {~ 'LR' i. {."1 in
+/ 2 ~:/\
<. 100 %~ 50 , 50 + +/\ S*X
