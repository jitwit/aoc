load '~/code/aoc/aoc.ijs'

in =: ];._2 aoc 2020 12

S =: (".@:}.) * 1 _1 0j1 0j_1 {~ 'EWNS' i. {.  NB. move
T =: (0j_1 0j1{~'RL'i.{.) ^ 1r90*".@:}.        NB. turn
M =: {{ (u y) (<v)} =i.3 }}                    NB. help parsing
PA =: (".@}. M 0 1)`(T M 1 1)`(T M 1 1)`(S M 0 2)@.('FRL'i.{.)
PB =: (".@}. M 0 1)`(T M 1 1)`(T M 1 1)`(S M 1 2)@.('FRL'i.{.)

P =: +/ . */ @ |. @: ("1) NB. modifier train for parsing transforms
G =: +/ @: | @ +. @ {. @ (+/ . *)~

0 1 1 G PA P in
0 10j1 1 G PB P in
