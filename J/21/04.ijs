load '~/code/aoc/aoc.ijs'
in =: aoc 2021 4
in =: (([:<".;._2);.2~ (2#LF)&E.) ' ' (I. ',' = in)} in,LF
bs =: }. &> }. in [ b =: ,> {. in
w =: [:{.0 0-.~,/@(* (,"0/~&i.)~/@$)
l =: [:{: 0 0-.~,/@(-.*(,"0/~&i.)~/@$)
c =: +./"1 @: (*./"_2)
'i j' =. ij =: w (c+.c@:(|:"_2)) bingo =: bs&e.\ b
(i{b) * +/,(j{bs) * -. (<ij) { bingo
'i j' =. ij =. 1 0 + l (c+.c@:(|:"_2)) bingo
(i{b) * +/,(j{bs) * -. (<ij) { bingo
