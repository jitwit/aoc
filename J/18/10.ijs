load '~/code/aoc/aoc.ijs'
in =: ];._2 aoc 2018 10
stars =: (4 2 2$0 10 _ 6  0 18 _ 6  0 36 _ 2  0 40 _ 2) ".;.0 in
'X V' =: _2 |:\ stars
P =: X + V&*
B =: */ @ (>./-<./) @ P"0 NB. area of bounding box, thing to minimize

bisect =: 1 : 0
 while. x <: y do. h =. <.-:x+y
   select. * 2 -~/\ u"0 h+i:1
   case. 1 1   do. y =. h-1
   case. _1 _1 do. x =. h+1
   case. do. break. end.
 end.
)

D =: {{ |: '*' (<"1 y)}' ' $~ 1 + >./ y =. (-"1 <./) y }}
]b =: 0 B bisect 20000
]a =: D P b

X =: (-"1 +/%#) X
V =: (-"1 +/%#) V
P =: X + V&*
- (X ([: +/ +/ . *"1) V) % V ([: +/ +/ . *"1) V

(0 ; 2 1) |: i. 3 3 3
