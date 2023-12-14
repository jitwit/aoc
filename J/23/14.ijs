load '~/code/aoc/aoc.ijs'
in =: ];._2 aoc 2023 14
eg =: ];._2 ] 0 : 0
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....
)
pad =: p"1@:p=.(,&'#')@('#'&,)
W =: ;@({{ < y /: '#O.' i. y }};.1)"1                 NB. fall west
N =: W&.|: [ E =: W&.|."1 [ S =: W&.(|:@:|.)          NB. fall other dirs
C =: E@:S@:W@:N                                       NB. spin cycle
+/(* i.@-@#) +/"1 'O' = N pad in                      NB. part a
'l m' =. C brent pad in                               NB. cycle detection
+/(*i.@-@#)+/"1'O'=C^:(m+l|1000000000-m) pad in       NB. part b
