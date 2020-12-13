load '~/code/aoc/aoc.ijs'

D =: ". {. 'D A' =: ];._2 aoc 2020 13
A =: 0 -.~ B =: ,".;._1 ',',A

A *&(((i.<./)T)&{) T =. A (|-) D      NB. part a
{. crt/ x: (* # i.@# ((|-)~,])"0 ]) B NB. part b
