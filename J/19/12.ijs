P =: |: 4 3 $ 3 2 _6 _13 18 10 _8 _1 13 5 10 4
V =: 3 4 $ 0

Q =: |: 4 3 $ _1 0 2 2 _10 _7 4 _8 8 3 5 _1

S =: P ; V
] vel"1 Q
NB. x pos, y vel. update velocity
vel =: ] + [: +/ [: * [ -/ [
update_vel =: (0 {:: ]) ; (0 {:: ]) (vel"1) 1 {:: ]
update_pos =: ((0 {:: ]) + 1 {:: ]) ; 1 {:: ]
step =: update_pos @ update_vel
hop =: (0{::]) (vel"1) (1{::])
energy =: [: +/ ([: +/ [: | 0&{::) * ([: +/ [: | 1&{::)
NB. (+/ @ | @ , @ 0&{::) * 

] energy (step ^: 1000) S