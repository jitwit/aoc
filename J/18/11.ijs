load '~/code/aoc/aoc.ijs'

]gsn =: {.".;._2 aoc 2018 11
P =: _5 + 10 | [: <. 100 %~ (10 + [) * gsn + ] * 10 + [
G =: P"0/~ 1 + i. 300

T =: 3 : 0
m =. (>./@,) v =. (,~y) (+/@,);._3 G
m ,. 4 $. $. m = v
)

]partA =: }. , 1 + T 3
]partB=: (1 + , }."1 T 14),1 + (i. >./) ({.@,@T)"0 (1+i.20)
