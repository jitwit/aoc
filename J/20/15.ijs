load '~/code/aoc/aoc.ijs'

in =: ".;._1 ',8,0,17,4,1,12'
iter =: , _1 + # - }: i: {: NB. slow but simple

solve =: 3 : 0 NB. not that fast
mem =: y$0
mem =: (1+i.#}:in) (}:in)} mem
curr =: {:in
for_j. (#in) + i. mem -&# in do.
  if. prev=.curr{mem
  do.   mem =: j curr} mem
        curr =: j-prev
  else. mem =: j curr} mem
        curr =: 0
  end.
end. curr
)

2019 { iter^:2020 in
NB. solve 30000000
