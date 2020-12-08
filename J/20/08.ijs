load '~/code/aoc/aoc.ijs vm8.ijs'

vm =: conew 'vm8'
create__vm aoc 2020 8

partA =: 3 : 0
 run__vm reset__vm ''
 acc__vm
)

partB =: 3 : 0
for_j. i. n=.#mem__vm do.
 swap__vm j [ run__vm swap__vm j [ reset__vm ''
 if. n = pc__vm do. acc__vm return. end.
end.
)

partA''
partB''
