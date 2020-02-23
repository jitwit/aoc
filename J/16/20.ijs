input=: /:~ > ([: ". (;._1) '-',]) &.> 'b' freads < '~/code/advent/input/16/20.in'

step=: verb define
j =. (0{"1 y)I.(<0 1){y
(((<0 0) { y) , >./ , j {. y) , j }. y
)

join1=: step ^: _
join2=: ({.,$:@}.)@:join1`]@.(0=#)

]partA=: >: (<0 1) { join1 input
]partB=: (2^32x) + +/ <: -/"1 join2 input





