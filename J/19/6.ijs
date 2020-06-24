load'~/code/aoc/aoc.ijs'
in=: ([:[;._1')',]);._2 aoc 2019;6
NB. (1!:1) < '../../input/19/6.in'

S=: in I.~ ]P=: /:~ > {./.~ ,/ in
T=: ([: {:"1 S #~ ({."1 S)&=) &.> <"0 i.#P
dfs=: [: ; ([:<,.) ; (>:@[ $: &.> T {::~ ]) NB. awkward...
'DV IV'=: |: > 0 dfs P I. 'COM'
NB. depth vector and ids
PV=: **(i: <:@{:)\ NB. calculate parent vector from depth vector

NB. trace along parents to get path
NB. find lca to find distance between planets.
path=: [: |. [: ({&(PV DV) ^: a:) IV i. ]
LCA=: [: ({.@:I.@:-.@:=/) ,:
dist=: (+&<:&# - 2*LCA) & path & (P&I.)

]partA=: +/ DV
]partB=: 'SAN' dist 'YOU'
