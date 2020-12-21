load '~/code/aoc/aoc.ijs'

in =: ([: <;._2 ,&LF) &.> (<;._2~ (2#LF)&E.) LF,(aoc 2020 20)
NB. (1!:1 < '20.in'),LF
I =: ([: {: 0 ". ':' -.~ 1&{::) &> in         NB. I for id
N =: %:#B =: ([: > 2&}.) &> in                NB. B for block, N for NxN grid
S =: [: (,|."1) {. , {: , ({.,:{:) @: |:      NB. S for sides
G =: (-=@i.@#) ([: +./ [: , -:"1/~&S)"2/~ B NB. connection graph
*/ I #~ 2 = +/ G NB. part A


C0 =: {. I. 2 = +/ G NB. corner/start
SYM =: (,|:"_1)@:(|:@|.^:(i.4))
H =: {:"2 X =: SYM"_1 B
M =: {{ , h #~ ({.y) ~: {."1 h =. 4 $. $. H -:"_2 _ {. X{~<y }}
R =: {{ (#~ ok"2) M^:(i.N)"1 y,.i.8 }}
ok =: (=&# ~.) {."1

NB. fill in sides, deselecting conflicting assignments
T =: {{ r #~ -. +./"1 {."_2 (x-.y) e.~ r =. R y }}

F =: 3 : 0
F2 =. {."1 {. c0 =. R y
{."_1 (F2&T)"0 F2
)

{."_2 F C0
