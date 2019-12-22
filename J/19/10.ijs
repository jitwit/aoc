grid =: 'm' freads '~/code/advent/input/19/10.in'
NB. grid =: 'm' freads 'tiny.in'

locate =: [: (j.~/"1) 4 $. [: $. =&'#'
angles =: [: # [: ~. 1 {"1 [: *. 0 -.~ ]
visible =: [: angles"1 [ -~/ ]
phi =: (o. 2) | 1 {"1 [: *. 0j1 * ]
the =: 1&{"1 @ *. @ *&0j_1
NB. the =: 13 : '(o. 2) | (1 {"1 (*. (0j1 * y)))'
NB. (o. 2)&| @: 1&{"1 @ *. @ *&0j1
organize =: (/: phi)
vaporize =: (198 i.~ [: +/\ [: ~: (- @ phi)) { (/: (- @ phi))
ixes =: ~: phi
orgn =: /: phi

partA =: >./ ] counts =. visible ] asteroids =. locate grid
station =: asteroids {~ counts i. partA
partB =: (vaporize &. (-&station)) (asteroids -. station)

partA;station;partB