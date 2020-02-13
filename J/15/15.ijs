require'~/code/advent/code/biblio.ijs tables/dsv'
]input=: > ". &.> _2&{. &.> ',' readdsv advent_input 15 15
NB. readdsv '15.in' NB. 

n=: 101
flatten=: (*/@:}: , {:)@$ $ ,
NB. reshape based on rank after unraveling
triples=: [: flatten ] ,"0 1/ [: flatten (,"0/~) f.
recipes=: |: (,~ <:@n-+/)"1 (] #~ (n > +/"1)) (triples i.n)

opt=: [: >./ [: */ 0 >. [: +/ (}:"1 input) *"0 1 ] f.
diet=: {"1~ [: I. 500 = [: +/ ({:"1 input) * ] f.

]partA=: opt recipes
]partB=: opt diet recipes
