load '~/code/aoc/aoc.ijs'

in =: ".;._1 ',8,0,17,4,1,12'
iter =: , _1 + # - }: i: {: NB. slow but simple

solve =: 3 : 0 NB. not that fast
mem =. y$0
mem =. (1+i.#}:in) (}:in)} mem
curr =. {:in
j =. #in
while. j<y do.
  if. prev=.curr{mem
  do.   mem =. j curr} mem
        curr =. j-prev
  else. mem =. j curr} mem
        curr =. 0
  end. j =. j+1
end. curr
)

2019 { iter^:2020 in
NB. solve 30000000
