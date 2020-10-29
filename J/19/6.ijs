load'~/code/aoc/aoc.ijs'
map =: ([: [;._1 ')'&,);._2 aoc 2019;6

T =: ({."1@])`({:"1@])`(i.@>:@#@])}~  NB. T for trees. edges => parent pointers
O =: T map i.~ P =: ~. ,/ map         NB. O for orbits, P for planets

D =: <: @ # @ ({&O ^: a:)             NB. D for depth
L =: +/ @ (=/) @ ,: & (|.@({&O^:a:))  NB. L for least common ancestor

]partA =: +/ D"0 i.#P
]partB =: 'SAN' (+&D - 2*L) & (P&i.) 'YOU'
