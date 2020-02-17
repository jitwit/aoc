grid =: 'm' freads < '~/code/advent/input/19/10.in'
NB. '~/code/advent/J/19/10.in'

locate =: [: (j.~/"1) 4 $. [: $. =&'#'
angles =: [: # [: ~. 1 {"1 [: *. 0 -.~ ]
visible =: [: angles"1 -/~

phi =: {:@*.@*&0j1

asteroids =: locate grid
]partA=: >./ ] counts =: visible asteroids
station=: asteroids {~ counts i. partA

NB. (/: phi)@(\: |)&.(-&station)
rebase=: ((/: phi) @ (#~ (~: phi)) @ (\: |)) &. (-&station) (asteroids -. station)

]partB=: 199 { rebase

matt=: '#' = grid
matt=: 2 (< +. station)}matt