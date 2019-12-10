grid =: 'm' freads '../../input/19/10.in'
eg =: 'm' freads 'small.in'

locate =: [: (j.~/"1) 4 $. [: $. =&'#'
NB. for each point: translate & count unique angles, after removing one 0
angles =: [: # [: ~. 1 {"1 [: *. 0 -.~ ]
visible =: [: angles"1 [ -~/ ]

partA =: >./ ] counts =. visible ] asteroids =. locate grid

NB. asteroid of maximum count. 198 because 0 index and phi puts first target last
station =: asteroids {~ counts i. partA
phi =: 1&{"1 @ *. @ *&0j_1
vaporize =: station + (198 i.~ [: +/\ [: ~: phi) { (/: phi)

partB =: asteroids ([: vaporize ] -~ -.) station

