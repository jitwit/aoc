grid =: 'm' freads '../../input/19/10.in'
eg =: 'm' freads 'small.in'

locate =: [: (j.~/"1) 4 $. [: $. =&'#'
asteroids =: locate grid

NB. for each point, count unique angles
angles =: [: # [: ~. 1 {"1 [: *. 0 -.~ ]
visible =: [: angles"1 [ -~/ ]

counts =: visible asteroids
partA =: >./ counts
station =: (locate grid) {~ counts i. partA
NB. [: i. >./ @ visible





