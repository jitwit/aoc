load '~/code/aoc/aoc.ijs'

in =: <;._2 aoc 2018 12

s0 =: '#' = 15}.>{.in
rs =: ((0,20+#s0),.0 5) ('#'&=);.0 > 2 }. in
ts =: (/: rs) { '#' = {:"1 > 2 }. in
pad =: (,&(5#0)) @: ((5#0)&,)
iter =: 5 (ts{~#.)\ pad
gens =: {{ (_3*i.y) +/@:(+I.)"0 _1 iter^:(i.y) s0 }}

ps =: gens 200 NB. 200 is enough for parts A and B

20 { ps NB. part A

j =: {. I. 2 =/\ 2 -~/\ ps
+/ (1,50000000000-j)*({.,-~/)(j+i.2) { ps NB. part B
