NB. will over comment so I can hopefully start to remember how this
NB. shit works.

NB. map over array of chars to set open paren = 1 and close paren =
NB. 0. then double and decrement to get 1 and _1.
floors =: <:+:'('&=1!:1<'../../input/15/1.in'
santas_trip =: +/\0,floors

NB. final floor
partA =: {:santas_trip

NB. find first appearance of _1 in trip
partB =: santas_trip i._1

partA;partB
