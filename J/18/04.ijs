load '~/code/aoc/aoc.ijs'
NB. setup & getting guard ids. can sort lexicographically because of
NB. how times are formated.
W =: in <;.1~ ([: +./ 'begins'&E.)"1 in =: /:~ ];._2 aoc 2018 4
I=: ~. G=: 0 ". > _3 {"1 ;: {.&> W

NB. only care about minutes after shift begins, alterates sleep/awake
N =: [: +/ _2 (1=I.&(1+i.60))\ (1 15,:_ 2)&(".;.0)
S =: G +//. N &> W

NB. modifier train to abstract out selection method
T =: ({&I * (i.>./) @ {&S) @ (i.>./) @: (/"1)

NB. guard who slept most, minute of most sleep * id
+ T S

NB. guard who slept most regularly, minute of most sleep * id
>. T S
