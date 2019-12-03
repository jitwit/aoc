require 'tables/csv'

source    =: {. makenum readcsv '../../input/19/2.in'

seed      =: [:0&;(1 2})          NB. put x at positions 1 2 of y
param_add =: [:+/1 2&+@[({{])]    NB. ip op1 mem => mem[pc+1] + mem[pc+2]
param_mul =: [:*/1 2&+@[({{])]    NB. ip op2 mem => mem[pc+1] * mem[pc+2]
addr      =: 3&+@[{]              NB. y[ip+3]
selop     =: [: 3&| 0&{:: { 1&{:: NB. mod 3 of ip to select by agenda in step

op_add    =: (4: + 0&{::) ; (0&{:: ((param_add`addr`])}) 1&{::)
op_mul    =: (4: + 0&{::) ; (0&{:: ((param_mul`addr`])}) 1&{::)

step      =: (]`op_add`op_mul)@.selop NB. small step of machine

eg1 =: 0;1 1 1 4 99 5 6 0 99
eg2 =: 0;1 9 10 3 2 3 11 0 99 30 40 50
]partA =: 0{1{:: step ^: _ ] 12 2 seed source NB. reach fixpoint of step
timex '0{1{:: step ^: _ ] 12 2 seed source'
