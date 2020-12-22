load '~/code/aoc/aoc.ijs'


in =: (([: < [: , [: }. ".;._1);._2~ (2#LF)&E.) LF,(aoc 2020 22),LF
NB. (1!:1 < '22.in'),LF
step =: 3 : 0
 'p1 p2' =. y
 if. 0=p1 <.&# p2 do. y
 elseif. p1 >&{. p2 do. ((}.p1), p1,&{. p2) ;}.p2
 else. (}.p1); (}.p2), p2,&{. p1
 end.
)

score =: +/@:(* 1+i.@-@#)

runA =: 3 : 0
 'a b' =. step ^: _ in
 if. #a do. score a else. score b end.
)

runA in
