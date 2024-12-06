load '~/code/aoc/aoc.ijs'
in =: ];._2 aoc 2024 6
dim =: $ G =: '#' = in
z0 =: +.^:_1 ] 4 $. $. '^' = in
dz =: _1

A =: {{ xy=.,+.z=.+/'w dz'=.y
        if. +./(xy<0 0),xy>:dim do. y
	elseif. (<xy){G do. w,0j_1*dz else. z,dz end. }}

#~.{."1 A^:a: z0,dz
