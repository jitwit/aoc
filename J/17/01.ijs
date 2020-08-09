load '~/code/aoc/aoc.ijs'

input=: "."0 }: aoc 2017;1

partA=: +/ (#~ (= 1 |. ])) input
partB=: +/ (#~ (= <.@-:@# |. ])) input
partA;partB