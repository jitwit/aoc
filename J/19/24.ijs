load '~/code/advent/code/biblio.ijs'
require 'viewmat'

world=:'#'='m' freads < advent_input 19 24

rule=: (3 2$1 1 0 1 0 2)e.~,
evolve=: rule/"0(1|.!.0])+(_1|.!.0])+(_1|.!.0"1])+1 |.!.0"1]
biodiversity=: 2&#. @ |. @ ,

floyd=: 3 : 0
h=. evolve]t=.evolve y [ mu=.0 [ lam=.1
while. -.h-:t do. t =. evolve t [ h =. evolve evolve h end.
h=.y
while. -.h-:t do. t=.evolve t [ h=.evolve evolve h [ mu=.>:mu end.
h=.evolve t
while. -.h-:t do. h=.evolve h [ lam=.>:lam end.
mu,lam
)

]partA=:biodiversity evolve ^:(>:0{floyd world) world
