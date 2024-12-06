load '~/code/aoc/aoc.ijs'
in =: ];._2 aoc 2024 6
dim =: $ G =: '#' = in
z0 =: +.^:_1 ] 4 $. $. '^' = in
dz =: _1

A =: 3 : 0
 xy =. , +. z =. +/ 'w dz' =. y
 out =. +./ (xy<0 0),(xy>:dim)
 if. out do. y elseif. (<xy){G do. w,0j_1*dz else. z,dz end.
)

#~.{."1 A^:a: z0,dz
