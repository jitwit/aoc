load '~/code/aoc/aoc.ijs'

in =: ];._2 aoc 2020 12

S =: (".@:}.) * 1 _1 0j1 0j_1 {~ 'EWNS' i. {.   NB. move
T =: (0j_1 0j1 {~'RL'i.{.) ^ 1r90*".@:}.        NB. turn
PF =: {{ (1,(".}.y),0),0 1 0,:0 0 1 }}          NB. forward
PT =: {{ 1 0 0,(0,(T y),0),:0 0 1 }}            NB. turn
PS =: {{ (1 0,S y),0 1 0,: 0 0 1 }}             NB. move ship
PW =: {{ 1 0 0,(0 1,S y),: 0 0 1 }}             NB. move waypoint
PA =: PF`PT`PT`PS@.('FRL'i.{.)                  NB. parse for a
PB =: PF`PT`PT`PW@.('FRL'i.{.)                  NB. parse for b

+/ | +. {. (+/ . */ |. PA"1 in) +/ . * 0 1 1    NB. part A
+/ | +. {. (+/ . */ |. PB"1 in) +/ . * 0 10j1 1 NB. part B
