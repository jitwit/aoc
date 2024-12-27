load'~/code/aoc/aoc.ijs'
salt =: }: aoc 2016 14
md5 =: 15&(128!:6)
H =: ([: md5 salt,":)"0 i. 36200
F =: {{if. #j=.I. 1 1 E. 2=/\{.y
       do. +./ , ] 1 1 1 1 1 E."1 (({.y){~{.j) = }. y
       else. 0 end. }}
63 { I. 1001 F\ H
H =: ([: md5^:2017 salt,":)"0 i. 23500
63 { I. 1001 F\ H
