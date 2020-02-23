require 'viewmat'
 
input =: freads < '~/code/advent/input/19/8.in'
layers =: _1 }. _150 [\ input

count=: [: +/"1 =
color=: [: {. [ {~ [: I. '2'&~:
solveA=: [: */ [: +/"1 '12' =/ ({~ (i. <./) @ count&'0')

]partA=: solveA layers
]partB=: (' J' {~ '1' = 6 25 $ color"1 @ |:) layers
