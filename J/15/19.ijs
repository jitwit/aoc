load '~/code/advent/code/biblio.ijs'
input=: 'b'freads<advent_input 15 19

molecule=: >{:input
rules=: }: > (({. , {:) @ ;:) &.> }: input

replace=: dyad define
ys=.0$y['in out'=. x
for_j. I. in E. y
do. ys=.(<(j{.y),out,((j+#in)}.y)),ys
end. <ys
)

spl=: [: < (0{::]) }. (1{::]) {. [
syms=: # ,~ [: I. 91 > a. i. ]
atoms=: spl"_ 1 (2 ]\ syms)
cnt=: [: +/ <@[ E. ]

]partA=: #a:-.~~.,>(replace&molecule)"1 rules
]partB=: <: (# - 'Ar'&cnt + 'Rn'&cnt + [: +: (,:'Y')&cnt) atoms molecule