require 'viewmat'
 
input =: freads < '~/code/advent/input/19/8.in'
layers =: _150 [\ input

count =: [: +/"1 =
minimize =: [ {~ [: (i. <./) ] 

partA =: (count&'1' * count&'2') @ (minimize count&'0')
partB =: ' J' {~ '1' = 6 25 $ ([: {. [ {~ [: I. '2'&~:)"1 @ |:

(partA;partB) layers

viewmat partB layers