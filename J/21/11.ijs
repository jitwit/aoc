load '~/code/aoc/aoc.ijs'
in =: "."0 ;._2 aoc 2021 11
F =: {{ f =. 0*y =. y+1
        while. -.f-:f+.g=.(-.f)*.y>9 do.
         f=.f+.g[y =. y + +/ (<:3 3#:i.9)|.!.0 g
        end. y * -. f+.g }}
+/,0=F^:(1+i.100)in
<: # F^:(+./@,)^:a: in
