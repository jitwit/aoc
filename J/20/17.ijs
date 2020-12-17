load '~/code/aoc/aoc.ijs'

W =: '#'&=;._2 aoc 2020 17
Z =: {{ for_d. i.#$y do. y =. 0,"(d+1)y,"(d+1),0 end. }}
nhood =: _1 + #&3 #: i.@:(3&^)
life =: {{((3=]-[*4=]) [: +/(nhood#$y)|.!.0"1 _/]) P y}}
+/ , life^:6 ,: W
+/ , life^:6 ,:^:2 W
