load'~/code/aoc/aoc.ijs intcode.ijs'

input=: ".;._1}:',',aoc 2019;9

run =: 3 : 0
 m =. conew 'intcode'
 create__m input
 output__m run__m y
)

run 1
run 2
