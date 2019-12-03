require 'tables/csv'

source =: {. makenum readcsv '../../input/19/2.in'
eg1 =: 1 1 1 4 99 5 6 0 99
eg2 =: 1 9 10 3 2 3 11 0 99 30 40 50

seed =: [:0&;(1 2}) NB. put x at positions 1 2 of y and box with ip
addr =: 3&+@[{] NB. y[ip+3]
param_add =: [:+/1 2&+@[({{])] NB. y[x+1] + y[x+2]
param_mul =: [:*/1 2&+@[({{])] NB. y[x+1] * y[x+2]

selop =: [: 3&| 0&{:: { 1&{::    NB. mod by 3 of ip to select by agenda in step
op_add =: (4: + 0&{::) ; 0&{:: param_add`addr`]} 1&{::
op_mul =: (4: + 0&{::) ; 0&{:: param_mul`addr`]} 1&{::

step =: ]`op_add`op_mul@.selop NB. small step of machine

run =: [: 0&{ [: 1&{:: step ^: _ @: seed  NB. reach fixpoint of step and read memory[0]
runA =: run&source
partA =: runA 12 2

r00 =: runA 0 0
drx =: (runA 1 0) - r00
dry =: (runA 0 1) - r00
partB =: (100*<.drx%~19690720-r00)+(dry%~drx|19690720-r00)

partA;partB
