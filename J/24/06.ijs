load '~/code/aoc/aoc.ijs'
in =: ];._2 aoc 2024 6
dim =: $ G =: '#' = in
dz =: _1 [ z0 =: +.^:_1 ] 4 $. $. '^' = in

A =: {{ xy=.,+.z=.+/'w dz'=.y
        if. +./(xy<0 0),xy>:dim do. y
	elseif. (<xy){G do. w,0j_1*dz else. z,dz end. }}

#~.{."1 A^:a: z0,dz
