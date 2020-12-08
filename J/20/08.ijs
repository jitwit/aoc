load '~/code/aoc/aoc.ijs vm8.ijs'

in =: aoc 2020 8

partA =: 3 : 0
 vm =. conew 'vm8'
 create__vm in
 run__vm ''
 acc__vm
)

partB =: 3 : 0
for_j. i.n=.+/LF=in do.
 vm =. conew 'vm8'
 create__vm in
 swap__vm j
 run__vm ''
 if. pc__vm = n do. acc__vm return. end.
end.
)
