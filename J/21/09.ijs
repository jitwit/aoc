load '~/code/aoc/aoc.ijs'
in =: "."0;._2 aoc 2021 9
s =: ((,-)=/~i.2)&(|.!.) NB. modifier train to shift and fill by left operand
+/,(1+in) * in < <./ 9 s in
*/ 3 {. \:~ #/.~ 0-.~,(* * ] >. >./@:(0 s))^:_ (*i.@$) 9 > in
