load '~/code/aoc/aoc.ijs'

W =: '#'&=;._2 aoc 2020 17
life =: {{for_d.i.s=.#$y do.y=.0,"(d+1)y,"(d+1),0 end.
          3=z-y*4=z=.+/(<:(s#3)#:i.3^s)|.!.0"1 _/y}}
+/,life^:6,: W
+/,life^:6,:^:2 W
