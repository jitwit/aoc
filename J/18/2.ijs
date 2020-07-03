load '~/code/aoc/aoc.ijs'
input=: ];._2 aoc 2018;2


]partA=: */ +/ (2 3 e./ [: +/ (=/ ~.))"1 input
]partB=: ({. #~ =/) input {~ 0 -.~ ~. , I. 1 = ([:+/-.@=)"1/~ input