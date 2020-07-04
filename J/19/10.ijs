load'~/code/aoc/aoc.ijs'
grid =: ];._2 aoc 2019;10

locate =: [: (j.~/"1) (4 $. $. @: =&'#')
angles =: [: # [: ~. 1 {"1 [: *. 0 -.~ ]
visible =: [: angles"1 -/~

station=: asteroids {~ counts i. partA=: >./ counts =: visible asteroids =: locate grid

phi =: {:@*.@*&0j_1
linedup=: (</.~ phi) (/: phi) (\: |) (asteroids - station) -. 0
NB. delete 0 because 0 corresponds to center
zapped=: ; (0 -.~ >@:({.&.>)) &.> <"_1 ({.&.>) ^: a: linedup
]partB=: station + 198 { zapped
NB. station + rebase {~ 199 I.~ +/\ 2 ~:/\ phi rebase NB. works because lucky input
