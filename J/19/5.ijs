load'~/code/aoc/aoc.ijs intcode.ijs'
input=: ".;._1}:',',aoc 2019;5

run =: 3 : 0
 m =. conew 'intcode'
 create__m input
 in__m =: in__m,y
 run__m ''
 {: out__m
)

run 1
run 5
