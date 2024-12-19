load'~/code/aoc/aoc.ijs intcode.ijs'
in=: ".;._1}:',',aoc 2019;5

run =: 3 : 0
 m =. conew 'intcode'
 create__m in
 output__m run__m,y
)

run 1
run 5
