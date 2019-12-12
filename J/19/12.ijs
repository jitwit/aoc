P =: |: 4 3 $ 3 2 _6 _13 18 10 _8 _1 13 5 10 4
V =: 3 4 $ 0

start =: P ; V

NB. x pos, y vel. update velocity
vel =: ] + [: +/ [: * [ -/ [
update_vel =: (0 {:: ]) ; (0 {:: ]) (vel"1) 1 {:: ]
update_pos =: ((0 {:: ]) + 1 {:: ]) ; 1 {:: ]
update =: update_pos @ update_vel
energy =: ([: +/ [: | [: , 0&{::) * ([: +/ [: | [: , 1&{::)
NB. (+/ @ | @ , @ 0&{::) * 

