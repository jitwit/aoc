require 'tables/csv'
NB. read number of tail of string, and multiply it by direction
NB. indicated by head of string
parse =: makenum@:}.*{&0j1 1 0j_1 _1@:I.@:E.&'URDL'@:{.
input=: parse &.> readcsv '../../input/19/3.in'

NB. cumulatively add moves
trip =: [: +/\ 0&, @: >
NB. two complex numbers, steps between
steps =: [ + ((%|) * 1+i.@|) @: -~
NB. list of points, calculate hops
wind =: [: steps/&.> 2 <\ ]

NB. awkward boxing gymnastics. need to avoid having items filled out by shape.
wires =: ,. ,; &.> <"1 wind"1 ,. trip"1 input

wireA =: +.,;>0{::wires
wireB =: +.,;>1{::wires

NB. sum x+y if both nonzero or 0
arr =: 1 $.(([: >: >./ - <./) wireA,wireB);0 1;0
crossings =: ((1+i.#wireA) ((<"1 wireA)}) arr) (([:*[)*+*[:*]) (1+i.#wireB) ((<"1 wireB)}) arr

(<./ 5$.crossings);~ 7$.crossings
