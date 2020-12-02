load '~/code/aoc/aoc.ijs'
in =: aoc 2018 13
nesw =: _2 ]\ _1 0  0 1  1 0  0 _1
carts =: '^>v<' [ dirs =: '|-|-'
right =: (+/ . *)&(0 _1,:1 0)
turn =: {{ right ^: (x-1) y }} NB. turn state represented by x in Z/3Z
cart =: {{ y ; (nesw {~ carts i. (<y){x) ; 0 }}
draw =: {{(carts {~ nesw i. > 1 {"1 cs) ({."1 cs)}w [ 'cs w' =. y}}

parse =: 3 : 0
 cs =. y&cart"1 ] 4 $. $. y e. carts
 cs ; '' ; (dirs {~ carts i. y {~ {."1 cs) ({."1 cs)} y
)

simulate =: 1 : 0
 if. u y do. y return. end. NB. u is stopping predicate
 'cs bs w' =. y
 ds =. 0 $ cs =. (/: {."1) cs
 while. #cs do.
  cs =. }. cs [ 'z dz t' =. {.cs
  select. (<z) { w
  case. '\' do. c =. ((z+dz);dz;t) [ dz =. nesw {~ (3 2 1 0 C. nesw) i. dz
  case. '/' do. c =. ((z+dz);dz;t) [ dz =. nesw {~ (1 0 3 2 C. nesw) i. dz
  case. '+' do. c =. ((z+dz);dz;(3|1+t)) [ dz=. t turn dz
  case. '|' do. c =. ((z+dz);dz;t)
  case. '-' do. c =. ((z+dz);dz;t)
  case. do. y return. end. NB. error
  if.     +/ msk =. ({.c) = ({."1 cs) do. cs =. (-.msk) # cs [ bs =. ({.c),bs
  elseif. +/ msk =. ({.c) = ({."1 ds) do. ds =. (-.msk) # ds [ bs =. ({.c),bs
  else.                                   ds =. c,ds end.
 end. ds;bs;w
)

world =: parse ];._2 in
NB. stop once first cart crashes
|.>1 {:: {{ * # 1 {:: y }} simulate^:_ world
NB. stop once 1 cart left
|.>{.,0 {:: {{ 1 = # 0 {:: y }} simulate^:_ world
