input =: 1!:1 < '../../input/19/8.in'
layers =: 100 150 $ input

count =: [: +/"1 =

minimize =: [ {~ [: (i. <./) ]
color =: [: {. [ {~ [: I. '2'&~:

partA =: (count&'1' * count&'2') @ (minimize count&'0')
partB =: ' J' {~ '1' = 6 25 $ color"1 @ |:

(partA;partB) layers