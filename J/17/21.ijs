load '~/code/aoc/aoc.ijs'

input =: 0 2 {"1 ([: <;._1 ' '&,);._2 aoc 2017;21

clean =: {~ ([: I. 2 > '#.'&i.)
rules =: (=&'#' @ clean) &.> input

rho2 =: 1 3 0 2
phi2 =: 1 0 3 2
rho3 =: 1 2 5 0 4 8 3 6 7
phi3 =: 2 1 0 5 4 3 8 7 6

NB. see math roots j lab slide 14 for better subgroup generation
SG=: 1 : '~.@(, ,/@(x/~))^:_'   NB. subgroup
p=: (1|.i.5),: (<0 1) C. i.5
rhos2 =: (rho2&C.^:0)`(rho2&C.^:1)`(rho2&C.^:2)
rhos3 =: (rho3&C.^:0)`(rho3&C.^:2)`(rho3&C.^:4)`(rho3&C.^:6)

fill =: 1 : 0
hd=. u &.> {."1 y
(; hd) ; > (# & > hd) # {:"1 y
)

rules2 =: ([: ~. [: (, phi2&C."1) rhos2`:0) fill rules #~ 4={."1 # & > rules
rules3 =: ([: ~. [: (, phi3&C."1) rhos3`:0) fill rules #~ 9={."1 # & > rules

match =: 1 : '(>{:u) {~ (>{.u) i. ,y'

iter2=: [: ,"_1/^:2 (,:~,~2) (3 3$rules2 match);._3 ]
iter3=: [: ,"_1/^:2 (,:~,~3) (4 4$rules3 match);._3 ]
iter=: iter2`iter3@.(2|#)

start=:3 3 $ 0 1 0 0 0 1 1 1 1
]partA =: +/ , iter^:5 start
]partB =: +/ , iter^:18 start