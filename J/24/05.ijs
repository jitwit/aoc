load '~/code/aoc/aoc.ijs'
in =: aoc 2024 5

R =: ([:".[:> 0 2{;:);._2 (1+n =: I. (LF,LF) E. in) {. in   NB. rules
L =: {{<".' '(I. js)}y[ js=.','=y}};._2 (n+2) }. in         NB. pages
P =: {{*./<:/"1 js #~ -.(#y) e."1 js=.y i. x}}              NB. in order?
+/(([:<.2%~#){])&> L#~C =: R&P &> L                         NB. part A

U =: ] F.. {{(|.x)(y i.x)}^:((*./x e.y)*.>:/y i.x) y}}      NB. update out of order pairs
+/(([:<.2%~#){])&> (U&R^:_) &.> L#~-.C                      NB. part B
