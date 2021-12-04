load '~/code/aoc/aoc.ijs'
in =: 1!:1 < '4.txt'
NB. aoc 2021 4
in =: (([:<".;._2);.2~ (2#LF)&E.) ' ' (I. ',' = in)} in,LF
bs =: }. &> }. in [ b =: ,> {. in
w =: [: {. 0 0 -.~ ,/@(* (,"0/~&i.)~/ @ $)
c =: +./"1 @: (*./"_2)
'i j' =. ij =: ([: w c +. c @: (|:"_2)) bingo =: bs&e.\ b
(i{b) * +/,(j{bs) * -. (<ij) { bingo
