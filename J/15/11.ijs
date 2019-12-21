input=:'hepxcrrq'

letter=:i.~&' abcdefghijklmnopqrstuvwxyz'
bump=: >:&.(27&#.)

r1=: [: 0 1 2&e. [: (- <./"1) 3 ] \ ]
r2=: [: -. [: +./ (letter ' iol')&e.
r3=: 1 < [: # [: ~. ] {~ [: I. [: (=/"1) 2 ]\ ]
good=: r1 *. r2 *. r3

next_password=: 3 : 0
y=. letter y
while. -. good y do. y=. bump y end.
y =. letter ^:_1 y
clipwrite y
y
)

]passwordA=: next_password input
]passwordB=: next_password (bump&.letter) passwordA
