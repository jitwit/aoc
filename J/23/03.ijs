load '~/code/aoc/aoc.ijs'
in =: ];._2 aoc 2023 3

NB. what is nice way of splitting each block of 1s??????
NB. spl =: ([:}:{.,0 1&E.) {{y}};.1]

pad =: (,&'.') @ ('.'&,)
Gn =: 3 3 (a09 e.~ (<1 1)&{);._3 pad"1 pad in      NB. numbers
Gc =: 3 3 ([:(*@#)('.',a09)-.~,);._3 pad"1 pad in  NB. adj to symbol
ixs =: (1,2(1<[:+/[:|-)/\ixs) <;.1 ixs=:4$.$.Gn    NB. indices of numbers, grouped
nums =: {{".(<"1 y){in }} &> ixs                   NB. number part values
+/ {{(".(<"1 y){in)*+./(<"1 y){Gc}} &> ixs         NB. part a
NB. gear ratio: find *, find numbers connected

NB. part b, for each * find which two groups of indices touch it.
+/{{*/y{nums}}"1 I.(#~2=+/"1){{(y&([:*./1 1>:[:<./[:|-"1))&>ixs}}"1]4$.$.'*'=in
