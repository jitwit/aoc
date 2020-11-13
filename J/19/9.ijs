load'~/code/aoc/aoc.ijs intcode.ijs'

input=: ".;._1}:',',aoc 2019;9

partA =: 3 : 0
 M =. conew'intcode'
 create__M 12 2 (1 2)}input
 bigstep__M ''
 {. program__M
)

run =: 3 : 0
 m =. conew 'intcode'
 create__m input
 in__m =: in__m,y
 run__m ''
 out__m
)

run 1
run 2
