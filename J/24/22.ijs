load'~/code/aoc/aoc.ijs'
in =: ".;._2 aoc 2024 22
M1 =: 16777216 | (22 b. 64&*) NB. `22 b.` is bitwise xor
M2 =: 16777216 | (22 b. [: <. %&32)
M3 =: 16777216 | (22 b. 2048&*)
F =: M3 @ M2 @ M1
M =: F^:(i.2001) in      NB. full table of prices
+/ {: M                  NB. part A
dM =: |: 2 -~/\ 10 | M   NB. table of differences
S =: ~. ,/ ] 4 ]\"1 dM   NB. unique sequences of length 4
NB. banana sales for sequence y:
B =: {{+/10|(<"1 t#~_~:{."1 t=.(,.i.@#)4+y([:{._,~I.@E.)"1 dM){M}}
NB. since brute force is slow, print progress as we look at banana
NB. sales from each sequence. for my input, the best sequence occurs
NB. in around 1/6 seed numbers, so one can generally terminate early.
partB =: 3 : 0
 b=.i=.0
 for_s. S do. echo (i%#S);b;t;s[i=.1+i[b=.b>.t=.B s end.
)
