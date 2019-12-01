require 'plot'

NB. 2d grid of complex numbers a + ib from argumemnt... i think the -
NB. is necessary because + conjugates right argument when applied? idk
zgrid =: +@j./-
grid_to_10 =: zgrid i.10


NB. cycloid.
] cycloid_x =: 2 1 o./ 0.01 * i.1000

cyc =: 4 : 0 NB.  R * (t - sin t, 1 - cos t)
R =. x
t =. y
(t + j. 1) + +/ 1 0j1 * 1 2 o./ t
)

NB. plot 1 cyc 0.1 * i.300

T =: 3 3 $ 'abcdefghijklmnop'
NB. (f y) g y  <=>  g f~
NB. eg, f = *:, g = +

NB. collatz can be defined using these verbs
odd =: 2 & |
grow =: 1 + *&3
shrink =: -:
NB. @. with odd basically computes odd n, and then selects the tied
NB. verb based on that index. if odd (odd 3 => 1) then grow, else
NB. shrink. note, 1 is implicitly the funciton \_ -> 1, since it is
NB. first position in fork of verbs.
collatz =: -:`(1+*&3)@.(2&|)

NB. we (/I) know how to compute the sum of a list with adverb insert
NB. /. here's us (me) learning recursion.

sum =: ({. + sum @ }.)` 0: @. (0 = #)

iter_cos =: 2&o.

test =: *: @ % @ (2&}. @: i.)


test 10
'boo'