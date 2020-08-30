load '~/code/aoc/aoc.ijs'
require 'viewmat'

world=:'#'=];._2 aoc 2019;24

rule=: (3 2$1 1 0 1 0 2)e.~,
life=: rule/"0(1|.!.0])+(_1|.!.0])+(_1|.!.0"1])+1|.!.0"1]
bio=: 2&#.@|.@,

bio_div=: [: bio [: life [: {: [: ([: ~. ] , life@{:)^:_ ,:
]partA=: bio_div world

NB. bug => exactly 1 or die
NB. empty => 1 or 2 or stay empty
