NB. boxes are lxwxh triples, so parse as csv with 'x' delimiter.
require 'tables/dsv'
boxes =: makenum 'x' readdsv '~/code/advent/input/15/2.in'

wrapping =: (<./ + 2 * +/) @: * 1&|.
ribbon   =: */ + 2 * +/ - >./

partA    =: +/ wrapping"1 boxes
partB    =: +/ ribbon"1 boxes

partA;partB
