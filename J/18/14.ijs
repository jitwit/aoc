in =: 2 9 3 8 0 1

stepA =: 3 : 0
 y =. 10 #. y [ 'e X' =. 0 1 ,: 3 7
 while. y>_10+#X
 do. X =. X,10#.^:_1 +/ r =. e { X
     e =. (#X) | 1+e+r
 end. 10 #. 10{.y}.X
)

stepB =: 3 : 0
 'e X' =. 0 1 ,: 3 7
 while. *. -. y +./@E. (-1+#y) {. X
 do. X =. X,10#.^:_1 +/ e { X
     e =. (#X) | 1+e+e{X
 end. I. y E. X
)

stepA in
