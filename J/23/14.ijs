load '~/code/aoc/aoc.ijs'
pad =: p"1@:p=.(,&'#')@('#'&,)
in =: pad ];._2 aoc 2023 14

W =: ;@(<@(/:'#O.'&i.);.1)"1                 NB. fall west
N =: W&.|: [ E =: W&.|."1 [ S =: W&.(|:@:|.) NB. fall other dirs
C =: E@:S@:W@:N                              NB. spin cycle
+/(*i.@-@#)+/"1'O'=N in                      NB. part a
'l m' =. C brent in                          NB. cycle detection
+/(*i.@-@#)+/"1'O'=C^:(m+l|1000000000-m) in  NB. part b
