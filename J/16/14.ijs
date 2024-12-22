load'~/code/aoc/aoc.ijs'
salt =: }: aoc 2016 14
md5 =: 15&(128!:6)
salt =: 'abc'
H =: ([: md5 salt,":)"0 i. 100000
dH =: 2 =/\"1 T
T =: I. +./"1 ] 1 1 E."1 dT NB. need to know which char is tripled...
P =: I. +./"1 ] 1 1 1 1 E."1 dT
