]input =: ". 'm' freads < '~/code/advent/input/16/19.in'

take1=: _2 {.\ ]
gift1=: $:@(take1`({:,take1@}:)@.(2|#))`{.@.(1=#)

take2=: verb define
h=. <.-:]n=. # y
ixs=. (([: <. [: -: n - ]) + +:)"0 i. h
s=. # ] ixs=. (ixs I. n) {. ixs
s |. y {~ (i. n) -. ixs
)

gift2=: take2 ^: _

]partA=: gift1 1+i.input
]partB=: gift2 1+i.input