load '~/code/aoc/aoc.ijs'

in =: <;._2 aoc 2018 12

s0 =: '#' = 15}.>{.in
rs =: ((0,20+#s0),.0 5) ('#'&=);.0 > 2 }. in
ts =: (/: rs) { '#' = {:"1 > 2 }. in
pad =: (,&(5#0))@:((5#0)&,)

NB. 200 is enough to reach steady state
20{gs =: (_3*i.200) +/@:(+I.)"0 _1 (5(ts{~#.)\pad)^:(i.200) s0

j =: {. I. 2 =/\ 2 -~/\ gs
(1,50000000000-j) +/ . * ({.,-~/)(j+i.2) { gs NB. part B
