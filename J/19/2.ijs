require 'tables/csv'

source =: {. makenum readcsv '~/code/advent/input/19/2.in'
eg1 =: 1 1 1 4 99 5 6 0 99
eg2 =: 1 9 10 3 2 3 11 0 99 30 40 50

seed =: [:0&;(1 2})
addr =: 3&+@[{]
param_add =: [:+/1 2&+@[({{])]
param_mul =: [:*/1 2&+@[({{])]

selop =: [: 3&| 0&{:: { 1&{::    NB. mod by 3 of ip to select by agenda in step
op_add =: (4: + 0&{::) ; 0&{:: param_add`addr`]} 1&{::
op_mul =: (4: + 0&{::) ; 0&{:: param_mul`addr`]} 1&{::
step =: ]`op_add`op_mul@.selop

run =: [: 0&{ [: 1&{:: step ^: _ @: seed
runA =: run&source
partA =: runA 12 2

step ^:a: 0;eg1
step ^:a: 0;eg2

r00 =: runA 0 0
drx =: (runA 1 0) - r00
dry =: (runA 0 1) - r00
partA;]partB =: (100*<.drx%~19690720-r00)+(dry%~drx|19690720-r00)
