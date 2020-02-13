load '~/code/advent/code/biblio.ijs tables/dsv'
input=: ' 'readdsv < advent_input 15 14

ixs=: 3 6 13
speeds=: > ". L: 0 ixs { &. |: input

NB. given time and speed, duration moving, rest, fill an array of positions
trace=: ([ $ (((1{]) # 0{]) , 0#~2{]))" _ 1
history=: +/\ |: 2503 trace speeds

partA=: >./ ^: 2 history
partB=: >./ +/ (= >./)"1 history

run=: verb define
echo partA;partB
if. IFQT
do. pal=. 2 3 $ 255 255 255 0 120 180
    require 'viewmat'
    pal viewmat history
end.
)

run''

