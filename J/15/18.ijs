load '~/code/advent/code/biblio.ijs'
grid=: '#' = 'm' freads < advent_input 15 18

small=: 6 6 $ '#' = '.#.#.#...##.#....#..#...#.#..#####..'

step=: (3=])`(e.&3 4)@.["0 0[:+/^:2(,"0/~i:1)&(|.!.0)
mask=: 3 : '1 (,/,"0/~(0,<:#y))} ($y) $ 0'
stick=: mask +. step

]partA=: +/ ^: 2 step ^: 100 grid
]partB=: +/ ^: 2 stick ^: 100 (+. mask) grid

update =: step
world =: grid

form=: noun define
pc life;
bin h;
  cc win isidraw; set win wh 200 200;
  bin v;
    cc reset button; cn "reset!";
    cc part combolist; set part items A B;
    cc dt edit; set dt text "10";
  bin z;
bin z;
pshow; timer 10;
)

life_close=: monad define
wd 'psel life;pclose;timer 0'
)

life_reset_button=: monad define
world =: grid
)

life_part_select=: monad define
select. {.wd'get part text'
  case. 'A' do. update =: step
  case. 'B' do. update =: stick
end.
'ok'
)

life_dt_button=: monad define
wd'psel life;timer ',wd'get dt text'
)

render=: monad define
wd'psel life'
world =: update world
glsel'win'
glclear''
viewmatcc (world;'win')
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