require 'viewmat'
 
input =: freads < '~/code/advent/input/19/8.in'
layers =: _1 }. _150 [\ input

count =: [: +/"1 =
minimize =: [ {~ [: (i. <./) ] 
color =: [: {. [ {~ [: I. '2'&~: 

partA =: (count&'1' * count&'2') @ (minimize count&'0')
partB =: ' J' {~ '1' = 6 25 $ color"1 @ |:

solve =: 3 : 0
if. IFQT do. ((,: 255&-) ?3#256) viewmat partB y end.
(partA;partB) y
)

solve layers