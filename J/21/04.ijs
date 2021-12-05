load '~/code/aoc/aoc.ijs'
in =: aoc 2021 4
bs=:}.&>}.in[b=:,>{.in=:(([:<".;._2);.2~(2#LF)&E.)' '(I.','=in)}in,LF
rs=:(+./"1@:(*./"_2)+.+./"1@:(*./"_3))bingo=:bs&e.\b
'i j'=:{.0 0-.~,/(*(,"0/~&i.)~/@$) rs
(i{b)*+/,(j{bs)*-.(<i,j){bingo NB. part a
'i j'=:1 0+{:0 0-.~,/(-.*(,"0/~&i.)~/@$) rs
(i{b)*+/,(j{bs)*-.(<i,j){bingo NB. part b
