load '~/code/aoc/aoc.ijs'
in =: "."0;._2 aoc 2021 9
S =: ((,-)=/~i.2)&(|.!.) NB. modifier train to shift and fill by left operand
+/,(1+in) * in < <./ 9 S in
*/3{.\:~ #/.~ 0-.~, (**]>.>./@:(0 S))^:_ (*i.@$) 9 > in
