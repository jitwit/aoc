load'~/code/aoc/aoc.ijs'
salt =: }: aoc 2016 14
md5 =: 15&(128!:6)
H =: ([: md5 salt,":)"0 i. 38000
F =: {{if. #j=.I. 1 1 0 E. 2=/\{.y
       do. +./ , ] 1 1 1 1 1 E."1 (({.y){~{.j) = }. y
       else. 0 end. }}
62 { I. 1001 F\ H NB. ???
bonsai 'md5 ^: 64 salt'
