clear''

load '~/code/advent/code/biblio.ijs'
require 'viewmat'
coinsert 'jviewmat jgl2'

W=: '.|#' i. 'm' freads < advent_input 18 18
NB. W=: '.|#' i. 'm' freads < '18.in'

adj=: (,"0/~i:1)&(|.!.0)
col=: [: |: [: ,/ adj
cell=: (3<:[:+/1=])`([:>:3<:[:+/2=])`([:+:(1<:[:+/1=])(*.)2<:[:+/2=])@.(4&{)
evolve=: [: cell"_2&.|: [: ,/ adj

partA=: [: (([: +/ 2 = ]) * [: +/ 1 = ]) [: , evolve^:10
] partA W
NB. GRAPHICS
pal =: 3 3 $ 187 187 187 15 15 51 255 255 102

launch=: verb define
wd'pc LIFE closeok'
wd'minwh 500 500; cc G isidraw;'
wd'pshow'
wd'psel LIFE'
)

render=: verb define
pal viewmatcc W;'G'
glpaint''
)

update=: verb define
W=: evolve W
)

step=: render@update

halt=: verb define
wd'timer 0'
)

NB. W=: ? 250 250 $ 3

sys_timer_z_=: step_base_
launch''

wd'timer 0'


