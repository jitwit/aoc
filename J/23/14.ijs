load '~/code/aoc/aoc.ijs'
in =: ];._2 aoc 2023 14
pad =: p"1@:p=.(,&'#')@('#'&,)
W =: ;@({{ < y /: '#O.' i. y }};.1)"1                 NB. fall west
N =: W&.|: [ E =: W&.|."1 [ S =: W&.(|:@:|.)          NB. fall other dirs
C =: E@:S@:W@:N                                       NB. spin cycle
+/(* i.@-@#) +/"1 'O' = N pad in                      NB. part a
a=.<./R}.~b=.>./R=:i.~ C^:(i.200) pad in              NB. cycle detection
+/(*i.@-@#)+/"1'O'=C^:(b+(1+b-a)|1000000000-b) pad in NB. part b
