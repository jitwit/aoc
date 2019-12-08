input =: 1!:1 < '../../input/19/8.in'
layers =: _150 [\ input

partA =: (count&'1' * count&'2') @ ([ {~ [: (i. <./) ] @ count&'0')
partB =: ' J' {~ '1' = 6 25 $ ([: {. [ {~ [: I. '2'&~:)"1 @ |:

(partA;partB) layers