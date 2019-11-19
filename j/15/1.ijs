NB. will over comment so I can hopefully start to remember how this
NB. shit works.

NB. map over array of chars to set open paren = 1 and close paren =
NB. 0. then double and decrement to get 1 and _1.
floors =: <:+:'('&= 1!:1 < '../../input/15/1.in'

NB. sum over array.
partA =: +/floors

NB. accumulate sum over array and find first index of _1. increment
NB. answer make it 1-indexed.
partB =: >:(+/\floors)i._1

partA;partB




