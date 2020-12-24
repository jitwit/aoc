load '~/code/aoc/aoc.ijs regex'

NB. (-1+-/3)/2
HEX =: ;: 'e ne nw w sw se'
P =: HEX i. 'sw|nw|ne|se|e|w'&rxall
A =: +/@:^@:((j. 1r3p1) * P)
NB. tolerant equality sucks
teq =: 1 : '|@- <:!.0 m * >.&|'
{{ (+:#y) - +/,0.00001 teq"0/~ y }}
n =: 2^_10
+/ 2 | #/.(!.n)~ A;._2 ] aoc 2020 24
NB. 1!:1 < '24.in'


