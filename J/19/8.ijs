layers =: _150 ]\ , ];._2 aoc 2019;8
NB. (1!:1) < '../../input/19/8.in'

color=: [: {. [ {~ [: I. '2'&~:
solveA=:[: */ [: +/"1 '12' =/ ({~ [: (i. <./) (+/ .=&'0'))

]partA=: solveA layers
]partB=: (' J' {~ '1' = 6 25 $ color"1 @ |:) layers
