require 'viewmat'

input=: freads < '~/code/advent/input/19/16.in'
digits=: _1 }. 0 "."0 input
unbase10=: 10&#:^:_1

base_pat=: 13 : '}. (>:x) $ , y&$"0 ] 0 1 0 _1'
base_mat=: base_pat"0 (>: @ i.)
flawed_ftA=: 8 {. (10 | [: | ] (+/ . *)~ base_mat @ #) ^: 100

drop_offset=: (]}.~#|10#.7{.]),]$~#*[:<.#%~(10000*#)-10#.7{.]
flawed_ftB=: 7 {. [: (10 | +/\.) ^: 100 drop_offset
tri=: [: -: (* >:)

viewmat base_mat 128
unbase10 &.> (flawed_ftA ; flawed_ftB) digits


