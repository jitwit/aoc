input =: 1!:1 < '../../input/19/8.in'
layers =: 100 150 $ input

count =: [: +/"1 =

minimize =: [ {~ [: (i. <./) ] NB. select index where minimimum is found
color =: [: {. [ {~ [: I. '2'&~: NB. find indices that aren't transparent and select first.

NB. find row with minimimum 0s and multiply # of 1s and 2s.
partA =: (count&'1' * count&'2') @ (minimize count&'0')

NB. transpose the layers to stack the pixels. rebuild in the shape of
NB. the decoded image (6x25) and make readable
partB =: [: {&' *' '1' = 6 25 $ color"1 @ |:

(partA;partB) layers