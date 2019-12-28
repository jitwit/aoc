require'tables/dsv ~/code/advent/code/biblio.ijs'

chart=: makenum' 'readdsv advent_input 15 13
people=: ~.,.0{"1 chart
identity=: verb def 'I.,>y&-:&.>people'

parse=: ([:identity 0{::]);([:identity _1}.[:>{:);([:<:[:+:'gain'-:2{::])*3{::]
NB. (0{::y);(_1}.>{: y);((<:+:'gain'-:2{::y)*(3{::y))

12{.]situations=: ,. > parse"1 chart
pairs=: 0 1{"1 situations [ scores=: 2{"1 situations
score=: scores {~ [: I. -:"1&pairs

happy_1way=:[:+/[:score"1((,.) 1&|.)
happiness=: happy_1way+happy_1way@|.

]partA=:>./ happiness"_1 (i.@! A. i.) 8
]partB=:>./ happiness"_1 (i.@! A. i.) 9