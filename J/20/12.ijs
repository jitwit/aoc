load '~/code/aoc/aoc.ijs'

in =: ];._2 aoc 2020 12
PF =: {{ (1,(".}.y),0),0 1 0,:0 0 1 }}
PR =: {{ 1 0 0,(0,(0j_1^1r90*".}.y),0),:0 0 1 }}
PL =: {{ 1 0 0,(0,(0j1^1r90*".}.y),0),:0 0 1 }}
PE =: {{ (1 0,".}.y),0 1 0,: 0 0 1 }}
PW =: {{ (1 0,-".}.y),0 1 0,: 0 0 1 }}
PN =: {{ (1 0,j.".}.y),0 1 0,: 0 0 1 }}
PS =: {{ (1 0,j.-".}.y),0 1 0,: 0 0 1 }}
Pe =: {{ 1 0 0,(0 1,".}.y),: 0 0 1 }}
Pw =: {{ 1 0 0,(0 1,-".}.y),: 0 0 1 }}
Pn =: {{ 1 0 0,(0 1,j.".}.y),: 0 0 1 }}
Ps =: {{ 1 0 0,(0 1,j.-".}.y),: 0 0 1 }}
PA =: PF`PR`PL`PE`PW`PN`PS@.('FRLEWNS'i.{.)
PB =: PF`PR`PL`Pe`Pw`Pn`Ps@.('FRLEWNS'i.{.)
+/ | +. {. (+/ . */ |. PA"1 in) +/ . * 0 1 1 NB. part A
+/ | +. {. (+/ . */ |. PB"1 in) +/ . * 0 10j1 1 NB. part B

