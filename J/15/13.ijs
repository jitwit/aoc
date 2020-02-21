require'tables/dsv ~/code/advent/code/biblio.ijs'

chart=: makenum' 'readdsv advent_input 15 13
id=: (,~.,.0{"1 chart)i.< NB. index of given person

parse=: ([: id 0{::]);([:id _1}.[:>{:);([:<:[:+:'gain'-:2{::])*3{::]

pairs=: 0 1{"1 situations [ scores=: 2{"1 ] situations=: ,. > parse"1 chart
score=: scores {~ [: I. -:"1&pairs

happy_1way=: [:+/[:score"1((,.) 1&|.)
happiness=: happy_1way+happy_1way@|.

]partA=:>./ happiness"_1 (i.@! A. i.) 8
]partB=:>./ happiness"_1 (i.@! A. i.) 9