load '~/code/aoc/aoc.ijs'
in =: ;: aoc 2023 8
E=:}."_1 G[V=:{."_1 G=:_3]\>(#~3=#&>)in[NAV =: >{.in
A=:{{ (i+1);('R'=NAV{~i|~#NAV){E{~V i.w['i w'=.y }}^:('Z'~:[:{:1&{::)
>{.A^:_ ]0;'AAA'                          NB. part a
*./>{."1 (A^:_)"1 ] 0;"1 V#~{:"1'A' = V   NB. part b
