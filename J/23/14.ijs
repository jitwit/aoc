load '~/code/aoc/aoc.ijs'
in =: (p"1@:p=.(,&'#')@('#'&,)) ];._2 aoc 2023 14
W =: ;@(<@(/:'#O.'&i.);.1)"1                NB. fall west
+/(*i.@-@#)+/"1'O'=W&.|: in                 NB. part a
C =: W&.|."1@:(W&.(|:@|.))@:W@:(W&.|:)      NB. spin cycle (ESWN)
'l m' =. C brent in                         NB. cycle detection
+/(*i.@-@#)+/"1'O'=C^:(m+l|1000000000-m) in NB. part b
