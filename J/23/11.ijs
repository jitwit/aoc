load '~/code/aoc/aoc.ijs'
in =: '#' = ];._2 aoc 2023 11

V=: I.-.+./in[H=:I.-.+./"1 in NB. vertical and horizontal empty indices
D=: {{ dx=.|-/H I.x0,x1[dy=.|-/V I.y0,y1['x1 y1'=.y['x0 y0'=.x
       ((<:u)*dx+dy) + +/|x-y }}
1r2*+/,2 D"1/~ 4$.$.in       NB. part a
1r2*+/,1000000 D"1/~ 4$.$.in NB. part b
