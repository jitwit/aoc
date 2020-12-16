load '~/code/aoc/aoc.ijs'

n =: 1 + +/ ','={:];._2 in =: aoc 2020 16
'R T S' =: (<;._2~ (2#LF)&E.) in,LF
nums =: {{ ". ' ' (I. -. y e. a09)} y }}
T =: {: nums ;._2 T,LF
R =: _2 (_1 0&+)\ nums R NB. omg this is why!
S =: (-n) ]\ nums S

VAL =: +./ *./"1 ] _2 +./\ R ([: +./ 1 = I.)"1 0/ S
G =: *./"2 ] _2 +./\ R ([: +./ 1 = I.)"1 0/ VAL # S NB. constraints graph

+/ (,S) #~ -. +./ R V"1 0/ ,S NB. part A

NB. find rows with only 1 option, and clear that option from the
NB. others, simpleton's vertex cover
A =: {{1(<"1 rs,"0 cs)}0(<a:;cs=.I.(rs=.I.1=+/"1 y){y)}y}}

*/ (6{. ,I. A^:_ G) { T NB. part B
