load '~/code/aoc/aoc.ijs'

dirs =: {."1 in =: ];._2 aoc 2020 12
n =: # mags =: ". }."1 in

S =: 0j1 0j_1 1 _1 {~ 'NSEW'&i.
T =: 0j_1 ^ %&90 NB. T for turn right. left is T@:-
partA =: 3 : 0
z =. 0
dz =. 1
for_j. i.n do. d =. j{dirs
               m =. j{mags
 if.     d e. 'F' do. z  =. z + m * dz
 elseif. d e. 'R' do. dz =. dz * T m
 elseif. d e. 'L' do. dz =. dz * T - m
 else. z =. z + m * S d
 end.
end. +/ | +. z
)
partA''

NB. object state is represented by position and direction, complex 2-vector
partB =: 3 : 0
z =. 0
w =. 10j1
for_j. i.n do. d =. j{dirs
               m =. j{mags
 if.     d e. 'F' do. z  =. z + m * w
 elseif. d e. 'R' do. w =. w * T m
 elseif. d e. 'L' do. w =. w * T - m
 else. w =. w + m * S d
 end.
end.
+/ | +. z
)
partB ''
