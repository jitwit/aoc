clear''
load '~/code/advent/code/biblio.ijs'
require 'viewmat'
coinsert 'jviewmat jgl2'

world=:'#'='m'freads<advent_input 19 24

rule=: (3 2$1 1 0 1 0 2)e.~,
life=: rule/"0(1|.!.0])+(_1|.!.0])+(_1|.!.0"1])+1|.!.0"1]
bio=: 2&#.@|.@,

bio_div=: [: bio [: life [: {: [: ([: ~. ] , life@{:)^:_ ,:
]partA=: bio_div world

visualize=: dyad define
if. IFQT
do. pal=. (, 255&-) ? 1 3 $ 256
    pal viewmat ,"2 life ^: (i.y) ? (x , x) $ 2
end.
)

NB. 18 visualize 300

NB. =========================================================
NB. animation
launch=: verb define
wd'pc LIFE closeok'
wd'minwh 800 800; cc G isidraw;'
wd'pshow'
wd'psel LIFE'
)

terminate=: verb define
wd'psel LIFE;pclose;timer 0'
)

P =: 2 3 $ 15 15 51 255 255 102

new_world=: verb define
world=: 1 < ? (y,y) $ 200
)

NB. render current world to G
render=: verb define
P viewmatcc world;'G'
glpaint''
)

update=: verb define
world=: life world
)

NB. updaet current world according to rule
step=: render@update

close=: verb define
wd'psel LIFE;pclose;timer 0'
)
new_world 400
sys_timer_z_=: step_base_
launch''
wd'timer 80'
NB. terminate''