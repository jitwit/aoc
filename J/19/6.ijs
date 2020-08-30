load'~/code/aoc/aoc.ijs'
in=: ([:[;._1')',]);._2 aoc 2019;6
NB. (1!:1) < '../../input/19/6.in'

NB. orbits=: in I.~ ]planets=: /:~ > {./.~ ,/ in NB. sorted to use I?

orbits=: in i.~ ]planets=: /:~ ~. ,/ in NB. sorted to use I?
E =: orbits
G0 =: 1 (<"1 E)}($. 0 $~ ,~ >: (>./@,) E)
G1 =: 1 (<"1 E)}(0 $~ ,~ >: (>./@,) E)

NB. PV = parent vector/self-pointer representation of planets
PV =: {:"1 (/:{."1) (, [: ,~ (i. # planets) -. {."1) |."1 orbits

NB. for parent vector m, finds path to root from node y
path=: 1 : '|. @: ({&m ^: a:)'
depth=: <:@#@(PV path)"0
partA=: +/ depth i. # planets

lca_depth=: [: +/ [: =/ (PV path"0 @ ,:)
]partB=: 'SAN' ((lca_depth) & (planets&i.)) 'YOU'


NB. T=: ([: {:"1 S #~ ({."1 S)&=) &.> <"0 i.#P
NB. dfs=: [: ; ([:<,.) ; (>:@[ $: &.> T {::~ ]) NB. awkward...
NB. 'DV IV'=: |: > 0 dfs P I. 'COM'
NB. NB. depth vector and ids
NB. PV=: **(i: <:@{:)\ NB. calculate parent vector from depth vector
NB. 
NB. NB. trace along parents to get path
NB. NB. find lca to find distance between planets.
NB. path=: [: |. [: ({&(PV DV) ^: a:) IV i. ]
NB. LCA=: [: ({.@:I.@:-.@:=/) ,:
NB. dist=: (+&<:&# - 2*LCA) & path & (P&I.)
NB. 
NB. ]partA=: +/ DV
NB. ]partB=: 'SAN' dist 'YOU'
NB. 