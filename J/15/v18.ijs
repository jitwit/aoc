load'~/code/advent/J/15/18.ijs'

NB. GL VISUAL
update =: step
world =: grid

form=: noun define
pc life;
bin h;
  cc win isidraw; set win wh 200 200;
  bin v;
    cc dt edit; set dt text "30";
    cc part combolist; set part items A B;
    cc random button; cn "random!";
    cc reset button; cn "reset!";
  bin z;
bin z;
pshow; timer 30;
)

pal=: 2 3 $ (3#0) , 215 255 241

life_close=: monad define
wd 'psel life;pclose;timer 0'
)

life_reset_button=: monad define
world =: grid
)

life_random_button=: monad define
world =: ? ($grid)$2
)

life_part_select=: monad define
select. {.wd'get part text'
  case. 'A' do. update =: step
  case. 'B' do. update =: stick
end. 'ok'
)

life_dt_button=: monad define
wd'psel life;timer ',wd'get dt text'
)

render=: monad define
wd'psel life'
world =: update world
glsel'win'
glclear''
pal viewmatcc (world;'win')
glpaint''
)

viz=: verb define
require'viewmat'
coinsert'jviewmat jgl2'
sys_timer_z_ =: render_base_
life_close ^: (wdisparent'life') ''
wd form
render''
)

viz ^: IFQT ''

