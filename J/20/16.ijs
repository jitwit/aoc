load '~/code/aoc/aoc.ijs'

in =: 1!:1 < '16.in' NB.
in =: aoc 2020 16
'rules ticket seats' =: (<;._2~ (2#LF)&E.) in,LF
nums =: {{ ". ' ' (I. -. y e. a09)} y }}
Ra =: _2 ]\ nums rules
NB. +/ (nums seats) {~ I. -. +./ 1 = Ra I."1 nums seats NB. former A
V =: {{ +./ 1 = x I."1/ y }}
S =: _3 ]\ nums seats
S =: _20 ]\ nums seats
T =: (*./"1 +./ 1 = Ra I."1/ S) # S
R =: _2 ]\ Ra

C =: *./"_2 ] 1 |: R V"_1 2 T

rows =:  {{ (i.#y) */ ((#y)#1) }}

H =: 3 : 0
 rs =. I. 1 = +/"1 y
 m =. y * (rows y) e. rs
 m + y * -. y * (|:rows y) e. (I. +./ rs { y)
)

OK =: [: -. [: +./ 0 = +/"1 NB. no inconsistency

B =: 3 : 0
 cs =. +/"1 y
 r =. cs i. <./cs-.1 NB. row, branch on possible rules
 if. r=#y do. ''
 else.
 bs =. (I. r { y) =/ i.#y
 < bs r}"1 _ y
 end.
NB. I. 1 = +/"1 y
)

I =: (#~ OK"_1) @: (B"_1) @: ((H^:_)"_1)
ok =: (#~ OK"_1)
h =: (H^:_)"_1
b =: [: ; B"_1
D =: [: *./ 1 = +/"1
d =: D"_1
gogo =: b @: ok @: h
NB. +/"1 ok h b ok h ok h b ok h ;B ok
6 {. R

