input =: 1!:1 < '../../input/19/8.in'
layers =: _150 [\ input

minimize =: [ {~ [: (i. <./) ]
partA =: (count&'1' * count&'2') @ (minimize count&'0')
partB =: ' J' {~ '1' = 6 25 $ ([: {. [ {~ [: I. '2'&~:)"1 @ |:

