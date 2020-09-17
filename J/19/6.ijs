load'~/code/aoc/aoc.ijs'
in=: ([:[;._1')',]);._2 aoc 2019;6

T =: 3 : '({."1 y) ({:"1 y)} i.>:#y'
U =: 1 : '{&m ^: a:'
O =: T in i.~ P =: ~. ,/ in
D =: <: @ # @ ({&O ^: a:)
L =: +/ @ (=/) @ ,: & (|.@({&O^:a:))

]partA =: +/ D"0 i.#P
]partB =: 'SAN' (+&D - 2 * L) & (P&i.) 'YOU'
