load'~/code/aoc/aoc.ijs'
d =: 101 103[in=: _4(_2]\])\".' '(I.-.in e.'_',a09)}in=. '_'(I.in e.'-')}in=.aoc 2024 14
F =: {{ (d|{.+y*{:)"_1 in }} NB. simulate y steps in time
D =: {{ |: '@' (<"1 F y)} d $ '~' }} NB. display F y in ascii
NB. find quadrants by subtracting half of the dimensions from each
NB. coordinate, removing points in middle (having 0), based upon sign
NB. of coordinates, convert to binary representation and count.
*/ #/.~ #. -: 1 + * V #~ -. +./"1 ]0 e.~"1 V=:(F 100)-"1<.-:d
NB. dimensions are prime so these coordinates will be periodic in
NB. x,y. find times with least variance in x,y, then solve system of
NB. equations using chinese remainder theorm to find out when xmas
NB. tree comes out.
{. crt/ d ,.~ (i.<./)"1 |: (var@F)"0 i. >./ d
