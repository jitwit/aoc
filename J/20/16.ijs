load '~/code/aoc/aoc.ijs'

n =: 1 + +/ ','={:];._2 in =: aoc 2020 16
'R T S' =: (<;._2~ (2#LF)&E.) in,LF
vals =: {{ ". ' ' (I. -. y e. a09)} y }}
T =: {: vals;._2 T,LF
R =: _2 (_1 0&+)\ vals R NB. omg this is why!
S =: _2 +./\ R ([:+./1=I.)"1 0/ V =: (-n) ]\ vals S

+/ (,V) #~ -. , +./ S NB. part A

NB. find rows with only 1 option, and clear that option from the
NB. others, simpleton's vertex cover
G =: *./"2 (+./ *./" 1 S) #"2 S NB. constraints
A =: {{1(<"1 r,.c)}0(<a:;c=.I.(r=.I.1=+/"1 y){y)}y}}

*/ (6{. ,I. A^:_ G) { T NB. part B
