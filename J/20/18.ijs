load '~/code/aoc/aoc.ijs exp.ijs'

in =: <;._2 aoc 2020 18

NB. reverse string and fix parens so ". works
p =: {{".'('(I.c)}')'(I.o)}y['o c'=.0 1=/'()'i.y=.|.&.;:y}}
+/ p&> in

NB. evaluate a block of tokens having no parens
eb =: 3 : 0
 d =. +/\ -. +./ _1 0|."0 1] y=<,'+'
 < ": ". ; d ((<@:":@:".@:(;:^:_1))`]@.(1=#))/. y
)

NB. evaluate deepest nesting of an expression and return result
eval =: 3 : 0
 if.     1=#y                 do. y
 elseif. 0=d=.>./0{::'D T'=.y do. eb T
 else. ts =. T ];.1~ ] _1 |.!.1 ] 1,~2 ~:/\ ms=.d=D
       ls =. _2 eb@:{:\ ts =. }:^:(1=2|#ts) ts
       ((-.ms)#D) ; < (-.ms)#ls(I.(T=<,'(')*.(d-1)=D)}T end.
)       

NB. uses mini s-expression lexer to parse parenthesized expressions
+/ ". > (eval^:_ @: sexp) &> in
