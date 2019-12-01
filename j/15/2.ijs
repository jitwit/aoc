
NB. boxes are lxwxh triples, so parse as csv with 'x' delimiter.
require 'tables/dsv'
boxes =: makenum 'x' readdsv '../../input/15/2.in'

NB. wrapping of a box is surface area + smallest side.
NB. so this is a monadic verb which first multiplies
NB. x1 ... xn * x2 ... xn x1, adds, then in later verb
NB. forks over the sum of the minimum side plus two times
NB. the sum of all sides.
wrapping =: (<./ + 2*+/) @: (]*1&|.)

NB. fork of the product of side lengths with two times the sum of the
NB. side lengths subtracted by the maximum basically, fork of sum -
NB. maximum and fork of 2 times that plus the product of the side
NB. lengths.
ribbon   =: */ + 2 * +/ - >./

NB. these simply apply the thus formed verbes by row.
partA    =: +/ wrapping"1 boxes
partB    =: +/ ribbon"1 boxes

partA;partB
