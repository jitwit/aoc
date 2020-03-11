input =: ([:<;._1')',]);._2 freads < '~/code/advent/input/19/6.in'

NB. planets: ravel the inputs, nub and sort
NB. orbits: sort input (on outgoing planet), then key on first column
planets=: /:~ ~. , input
orbits=: ({."1 ({.^:2 ; [:<[:<"0{:"1)/. ]) planets I. /:~ input
orbits=: {:"1 /:~ orbits , (a:,~<)"0 (i.#planets) -. > {."1 orbits

dfs=: [: ; ([:<,.) ; (>:@[ $: &.> orbits {::~ ]) NB. awkward...
NB. calculate depth vector
'depths ids'=: |: > 0 dfs planets I. <'COM'

NB. calculate parent vector from depth vector
PP=: 0,[:}.(i:<:@{:)\
NB. trace along parents to get path
path=: [: |. [: ({&(PP depths) ^: a:) ids i. planets I. <
NB. find lca to find distance between planets.
orbital_transfers=: (+&<:&# - [:+:[:{.[:I.[:-.[:=/,:) & path

]partA=: +/ depths
]partB=: 'SAN' orbital_transfers 'YOU'
