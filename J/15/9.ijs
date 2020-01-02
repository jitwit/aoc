require 'tables/dsv'
load '~/code/advent/code/biblio.ijs'

input=: makenum' 'readdsv < advent_input 15 9

distances=: > 4{"1 input
]cities=: ~. 0{"1 input
map=: > (cities&i.@<) &.> 0 2{"1 input
d=: [: {&distances map&i. @ /:~
D=: [: +/ d"1 @ }: @ (,. 1&|.)

(<./;>./) D"1 (i.@! A. i.) >: # cities


