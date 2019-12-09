require 'tables/csv'

parse =: makenum@:}.*{&0j1 1 0j_1 _1@:('URDL'&i.)@:{.
input=: parse &.> readcsv '../../input/19/3.in'

steps =: [ + ((%|) * 1+i.@|) @: -~
unwind =: [: steps/&.> 2 <\ ]
wires =: ,. ,; &.> <"1 unwind"1 ,. ([: +/\ 0&, @: >)"1 input

wireA =: +.,;>0{::wires
wireB =: +.,;>1{::wires

NB. arr =: 1 $.(([: >: >./ - <./) wireA,wireB);0 1;0
mk =: 1 $. (0 1;0) ;~ [: ([: >: >./ - <./) ,
arr =: wireA mk wireB

NB. sum x+y if both nonzero or 0
intersection =: ([: * [) * + * [: * ]
crossings =: ((1+i.#wireA) ((<"1 wireA)}) arr) intersection (1+i.#wireB) ((<"1 wireB)}) arr

(7$.crossings) ; (<./ 5$.crossings)
