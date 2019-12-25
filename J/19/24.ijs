load '~/code/advent/code/biblio.ijs'
require 'viewmat'

world=:'#'='m'freads<advent_input 19 24

rule=: (3 2$1 1 0 1 0 2)e.~,
life=: rule/"0(1|.!.0])+(_1|.!.0])+(_1|.!.0"1])+1|.!.0"1]
bio=: 2&#.@|.@,

bio_div=: [: bio [: life [: {: [: ([: ~. ] , life@{:)^:_ ,:
]partA=: bio_div world

visualize=: 3 : 0
pal=. (, 255&-) ? 1 3 $ 256
pal viewmat ,"2 life ^: (i.y) ? 5 5 $ 2
)

visualize 50