load '~/code/advent/code/biblio.ijs'
require 'viewmat'

world=:'#'='m' freads < advent_input 19 24

rule=: (3 2$1 1 0 1 0 2)e.~,
evolve=: rule/"0(1|.!.0])+(_1|.!.0])+(_1|.!.0"1])+1|.!.0"1]
biodiversity=: 2&#.@|.@,

find_repeat=: 3 : 0
seen=. 0 $ 0 [ world=.y
while. -. (biodiversity world) e. seen
do. world =. evolve world [ seen=.(biodiversity world),seen
end.
biodiversity world
)

]partA=:find_repeat world