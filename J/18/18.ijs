clear''

load '~/code/advent/code/biblio.ijs'
require 'viewmat'
coinsert 'jviewmat jgl2'

W=: '.|#' i. 'm' freads < advent_input 18 18
NB. W=: '.|#' i. 'm' freads < '18.in'

adj=: (,"0/~i:1)&(|.!.0)
cell=: (3<:[:+/1=])`([:>:3<:[:+/2=])`([:+:(1<:[:+/1=])(*.)2<:[:+/2=])@.(4&{)
evolve=: [: cell"_2&.|: [: ,/ (,"0/~i:1)&(|.!.0)

partA=: [: (([: +/ 2 = ]) * [: +/ 1 = ]) [: , evolve^:10
] partA W
NB. GRAPHICS
pal =: 3 3 $ 15 15 51 187 187 187 255 255 102

launch=: verb define
wd'pc LIFE closeok'
wd'minwh 800 800; cc G isidraw;'
wd'pshow'
wd'psel LIFE'
wd'timer 20'
)

render=: verb define
pal viewmatcc world;'G'
glpaint''
)

update=: verb define
world=: evolve world
)

step=: render@update

halt=: verb define
wd'timer 0'
)

reset=: verb define
world=: 60 80 I. ? 100 100 $ 100
)

close=: verb define
wd'psel LIFE;pclose;timer 0'
)

sys_timer_z_=: step_base_
close ^: (wdisparent'LIFE') ''
launch''
reset''
