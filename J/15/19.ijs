clear''
load '~/code/advent/code/biblio.ijs'

input=: 'b'freads<advent_input 15 19

molecule=: >{:input
rules=: }: > (({. , {:) @ ;:) &.> }: input

react=: verb define
'j in out mol'=.y
<(j{.mol),out,((j+#in)}.mol)
)

replace=: dyad define
ys=.0$y['in out'=. x
for_j. I. in E. y do. ys=.(react j;in;out;y),ys end.
<ys
)

]partA=: #(<'')-.~~.,>(replace&molecule)"1 rules

rs=: |."1 rules /: (-/"1 > # L:0 rules)

NB. try to go from start to 'e' with rs

