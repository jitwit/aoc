load '~/code/aoc/aoc.ijs'
in =: aoc 2018 13
in0 =: 1!:1 < '13.in'
world =: ];._2 in0
nesw =: 2 1 0 3 C. (,-)=/~i.2
carts =: '^>v<' [ dirs =: '|-|-'
right =: (+/ . *)&(0 _1,:1 0)
turn =: {{ right ^: (x-1) y }} NB. turn state represented by x in Z/3Z

cart =: {{ y ; (nesw {~ carts i. (<y){x) ; 0 }}

parse =: 3 : 0
 cs =. y&cart"1 ] 4 $. $. y e. carts
 cs ; (dirs {~ carts i. y {~ {."1 cs) ({."1 cs)} y
)
draw =: 3 : 0
 'cs w' =. y
 if. #cs do. (carts {~ nesw i. > 1 {"1 cs) ({."1 cs)}w else. w end.
)
simulate =: 3 : 0
 'cs w' =. y
 ds =. 0 $ cs =. (/: {."1) cs
 while. #cs do.
   cs =. }. cs [ 'z dz t' =. {.cs
   select. (<z) { w
   case. '\' do. c =. ((z+dz);dz;t) [ dz =. nesw {~ dz i.~ 3 2 1 0 C. nesw
   case. '/' do. c =. ((z+dz);dz;t) [ dz =. nesw {~ dz i.~ 1 0 3 2 C. nesw
   case. '+' do. c =. ((z+dz);dz;(3|1+t)) [ dz=. t turn dz
   case. '|' do. c =. ((z+dz);dz;t)
   case. '-' do. c =. ((z+dz);dz;t)
   case. do. cs;w return. end.
   if. +/ msk =. ({.c) = ({."1 cs) do. cs =. (-.msk) # cs
   elseif. +/ msk =. ({.c) = ({."1 ds) do. ds =. (-.msk) # ds
   else. ds =. c,ds end.
 end.
 ds;w
)

partA =: 4 : 0
  w =. parse y
  i =. 0 [ n =. #>{.w
  while. x > i =. >:i do.
    w =. simulate w
    if. n > #>{.w do. (i;{.w) return. end.
  end. i
)

partB =: 4 : 0
  w =. parse y
  i =. 0
  while. x > i =. >:i do.
    w =. simulate w
    if. 1 = #>{.w do. i;w return. end.
  end. i
)

300 partA ];._2 in
2 {. 20000 partB ];._2 in

