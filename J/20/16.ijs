load '~/code/aoc/aoc.ijs'

NB. in =: 1!:1 < '16.in' NB.
in =: aoc 2020 16
n =: 1 + +/ ','={:];._2 in
'rules ticket seats' =: (<;._2~ (2#LF)&E.) in,LF
nums =: {{ ". ' ' (I. -. y e. a09)} y }}
R =: _2 (_1 0&+)\ nums rules NB. omg this is why!
S =: (-n) ]\ nums seats
V =: [: +./ 1 = I.
NB. invalid tickets
VAL =: +./ *./"1 ] _2 +./\ R V"1 0/ S
+/ (,S) #~ -. +./ R V"1 0/ ,S NB. part A

T =: VAL # S
G =: *./"2 ] _2 +./\ R V"1 0/ T
rows =: (#"0 i.) n

NB. (240 20 50 ,: 0 255 100) viewmat
A =: 3 : 0
 rs =. I. 1 = +/"1 y
 cs =. I. rs { y
 1 (<"1 rs,"0 cs)}0 (<a:;cs)} y
)

deps =: , 6 {. I. A ^: _ G

*/ deps { {: nums ;._2 ticket,LF
