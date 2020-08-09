load '~/code/aoc/aoc.ijs'
input=: ,/ ([: ".;._1 ' ',]);._2 aoc 2017;2

partA=: +/ (>./ - <./)"1 input
partB=: +/ ([: %~/ [: , ] {~ (,~@#) #: [: I. [: , = -~ 0 = |/~)"1 input

partA;partB