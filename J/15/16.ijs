load'~/code/advent/code/biblio.ijs tables/dsv'

memories=: 'children 3 cats 7 samoyeds 2 pomeranians 3 akitas 0 vizslas 0 goldfish 5 trees 3 cars 2 perfumes 1'
]facts=: _2 ]\ ;: memories

parse=: [: ;: ':' delstring ',' delstring ]
input=: > (_2 ]\ 2 }. parse) &.> 'b' freads < advent_input 15 16

cmpA=: 3 : '''='''
cmpB=: '<<>>=' {~ (;:'cat trees pomeranians goldfish')&i.

NB. if fact not remembered 1 else compare values on u
match=: 1 : '1:`([:".(>@{:@[),(u@{.@[),[:>[:{:]{~[:{.[i.~[:{."1])@.([:{.[e.[:{."1])'
solve=: 1 : '>: I. (#facts) = +/ facts (u match"1 2)/ input'

]partA=: cmpA solve
]partB=: cmpB solve
