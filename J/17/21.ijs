require 'tables/dsv'

input =: 0 2{"1 ' ' readdsv < '../../input/17/21.in'
clean =: {~ ([: I. 2 > '#.'&i.)
rules =: (=&'#' @ clean) &.> input

r2 =: 6 {. rules
r3 =: 6 }. rules

NB. rho for rhotate, phi for phlip
rho2 =: 1 3 0 2 [ phi2 =: 1 0 3 2 [ rho3 =: 1 2 5 0 4 8 3 6 7 [ phi3 =: 2 1 0 5 4 3 8 7 6

NB. there's no doubt a better way to do this, but good is the enemy of ok.
rhos2 =: (rho2&C.^:0)`(rho2&C.^:1)`(rho2&C.^:2)
rhos3 =: (rho3&C.^:0)`(rho3&C.^:1)`(rho3&C.^:2)`(rho3&C.^:3)`(rho3&C.^:4)`(rho3&C.^:5)`(rho3&C.^:6)`(rho3&C.^:7)
keys2 =: [: ~. [: (, phi2&C."1) rhos2`:0
keys3 =: [: ~. [: (, phi3&C."1) rhos3`:0

exp2 =: 1&{:: ;~ ([: keys2 0&{::)
exp3 =: 1&{:: ;~ ([: keys3 0&{::)

rules2 =: exp2"1 r2
rules3 =: exp3"1 r3

match =: 0 1 {:: ] {~ [: I. (e. 0&{::)"1
match2 =: match&rules2
match3 =: match&rules3

start=:0 1 0 0 0 1 1 1 1
iter1=:start match rules3

d2=: -@[ ]\ ]

it2=: 4 4 $ iter1
plz=: |:"2 (2&d2"2 (|:"2 (,."3 (2 2 2 2 $ iter1))))

NB. row2=: 2 * <. @: % NB. 2x2
NB. col2=: 2 * |
