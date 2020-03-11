load'~/code/advent/code/biblio.ijs tables/dsv'
input=: > ". &.> _2&{. &.> ',' readdsv advent_input 15 15
flatten=: (*/@:}:,{:)@$$,
triples=: [:flatten],"0 1/[:flatten(,"0/~)
recipes=: |: (,~ <:@101-+/)"1 (] #~ (101 > +/"1)) (triples i.101)

opt=: [: >./ [: */ 0 >. [: +/ (}:"1 input) *"0 1 ]
diet=: {"1~ [: I. 500 = [: +/ ({:"1 input) * ]

]partA=: opt recipes
]partB=: opt diet recipes