parse=: [:,[:>[:([:".;._1'x',])&.>2}.[:<;._1' ',':'-.~]
input=: }: parse ;._1 LF,freads < '~/code/advent/input/18/3.in'

lo=: 2&{.
hi=: 2&{. + 2&}.

patch=: [: (<"1) lo +"_ 1 [: ,/ (i.@(2&{)) ,"0/ (i.@(3&{))

elf=: 3 : '1 (patch y)} (1000 1000 $ 0)'
]partA=: (+/^:2) 2 <: +/ elf"1 input

overlap=: ([:*./lo@]<:hi@[) *. ([:*./lo@[<:hi@])
]partB=: >: I. 1 = +/ overlap"1/~ input