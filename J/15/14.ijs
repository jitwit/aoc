load '~/code/advent/code/biblio.ijs tables/dsv'

ixs=: 3 6 13
input=: ' 'readdsv < advent_input 15 14
speeds=: > ". L: 0 ixs { &. |: input

NB. given time and speed, duration moving, rest, fill an array of positions
trace=: [ $ ((1 { ]) # 0 { ]) , 0 #~ 2 { ]
race=: 2503 trace"0 1 speeds

partA=: >./ +/"1 race
partB=: >./ +/ (= (>./))"1 +/\ |: race

partA;partB

