load '~/code/aoc/aoc.ijs'
parse=: [:,[:>[:([:".;._1'x',])&.>2}.[:<;._1' ',':'-.~]
input=: parse;._2 aoc 2018;3

lo=: 2&{.
hi=: lo + 2&}.

patch=: [:(<"1) lo +"_ 1 [:,/(i.@(2&{)),"0/(i.@(3&{))
overlap=: ([:*./ lo@] <: hi@[) *. ([:*./ lo@[ <: hi@])

]partA=: #~.(#~[:-.~:)a:-.~,patch"1 input
]partB=: >:I.1=+/overlap"1/~ input