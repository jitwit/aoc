input=: 1!:1 < '../../input/19/16.in'
digits=: _1 }. 0 "."0 input
drop_beginning=: (]}.~#|10#.7{.]),]$~#*[:<.#%~(10000*#)-10#.7{.]
flawed_ft=: 10 (#:^:_1) 7 {. [: (10 | +/\&.|.) ^: 100 drop_beginning

] partB=: flawed_ft digits