load '~/code/aoc/aoc.ijs'
n=:1++/','={:];._2 in=:aoc 2020 16
'R T S'=:(<;._2~(2#LF)&E.)in,LF
vals=: {{".' '(I.-.y e.a09)}y}}
R=:_2(_1 0&+)\vals R[T=:{:vals;._2 T,LF
S=:_2+./\R([:+./1=I.)"1 0/V=:(-n)]\vals S
+/(,V)#~-.,+./S                                    NB. part A
C=:{{1(<"1 r,.c)}0(<a:;c=.I.(r=.I.1=+/"1 y){y)}y}} NB. C for constrain
*/T{~6{.,I.C^:_*./"2(+./*./"1 S)#"2 S              NB. part B
