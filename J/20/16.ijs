load '~/code/aoc/aoc.ijs'

n =: 1 + +/ ','={:];._2 in =: aoc 2020 16
'R T S' =: (<;._2~ (2#LF)&E.) in,LF
nums =: {{ ". ' ' (I. -. y e. a09)} y }}
T =: {: nums ;._2 T,LF
R =: _2 (_1 0&+)\ nums R NB. omg this is why!
S =: _2 +./\ R ([:+./1=I.)"1 0/ V =: (-n) ]\ nums S
G =: *./"2 (+./ *./" 1 S) #"2 S NB. constraints

+/ (,V) #~ -. , +./ S NB. part A

NB. find rows with only 1 option, and clear that option from the
NB. others, simpleton's vertex cover
A =: {{1(<"1 r,"0 c)}0(<a:;c=.I.(r=.I.1=+/"1 y){y)}y}}

*/ (6{. ,I. A^:_ G) { T NB. part B
