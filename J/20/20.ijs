load '~/code/aoc/aoc.ijs'

NB. 
in =: (<;._2~ (2#LF)&E.) LF,(1!:1 < '20.in'),LF
NB. LF,(aoc 2020 20)
P =: [: <;._2 ,&LF
Id =: {{{: 0 ". ':'-.~ 1 {:: y}}
S =: P &.> in
ids =: Id &> S
img =: ([: > 2&}.) &> S

sides =: [: (,|."1) {. , {: , ({.,:{:) @: |:
C =: [: +./ [: , -:"1/~&sides
G =: (-=/~@i.@#) C"2/~ img
*/ ids #~ 2 = +/ G


NB. ok so we know corners.
NB. want to build image
NB. plan, start with corner. connect it.
NB. connect each row.
NB. need to now know how to connect
node =: 3 : 0
t =. y bfs G
d =. <: #@~."1 |: ({&t)^:a: t
NB. ({&t)^:a:
t ; d ; d = (<:%:#G)
)

start =: 3 : 0
'a b' =. I. G {~ c =. 1 i.~ 2 = +/ G
s1 =. 1 i.~ +/ (c{img) -:"1/~&sides (a{img)
s2 =. 1 i.~ +/ (c{img) -:"1/~&sides (b{img)
s1,s2
)

start ''
|. 1 { img
