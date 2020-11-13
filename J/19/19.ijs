load '~/code/aoc/aoc.ijs intcode.ijs'

]input=: ".;._1}:',',aoc 2019;19

beam =: 4 : 0"0 0
 m =. conew 'intcode'
 create__m input
 output__m run__m x,y
)

+/ , patch =: beam/~ i. 50
