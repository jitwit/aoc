load'~/code/aoc/aoc.ijs'
load 'intcode.ijs'

input=: ".;._1}:',',aoc 2019;2

eg1 =: 1 1 1 4 99 5 6 0 99
eg2 =: 1 9 10 3 2 3 11 0 99 30 40 50

partA =: 3 : 0
  M =. conew'intcode'
  create__M 12 2 (1 2)}input
  bigstep__M ''
  {. program__M
)

bonsai 'partA'''''
