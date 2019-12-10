grid =: 'm' freads '../../input/19/10.in'

locate =: [: (j.~/"1) 4 $. [: $. =&'#'
angles =: [: # [: ~. 1 {"1 [: *. 0 -.~ ]
visible =: [: angles"1 [ -~/ ]
phi =: 1&{"1 @ *. @ *&0j_1
vaporize =: (198 i.~ [: +/\ [: ~: phi) { (/: phi)

partA =: >./ ] counts =. visible ] asteroids =. locate grid
station =: asteroids {~ counts i. partA
partB =: (vaporize &. (-&station)) asteroids -. station


