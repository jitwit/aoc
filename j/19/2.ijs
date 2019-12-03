require 'tables/csv'

source =: {. makenum readcsv '../../input/19/2.in'

NB. ip op1 mem => mem[pc+1] + mem[pc+2]
ops =: (+/)`(*/)
op1 =: [: +/ 1 2&+ @ [ ({ { ]) ]
op2 =: [: */ 1 2&+ @ [ ({ { ]) ]
addr =: 3&+@[{] NB. y[ip+3]
fkyah1 =: op1`addr`]
fkyah2 =: op2`addr`]

machine =: 4 : 0
mem =. x (1 2}) y
ip =. 0
while. 1 do.
  select. ip{mem
    case. 1 do. mem =. ip fkyah1 } mem
    NB. (ip op1 mem) ((3+ip){mem) } mem NB. 
    case. 2 do. mem =. ip fkyah2 } mem
    case. 99 do. break.
  end.
  ip =. ip + 4
end.
0{mem
)

]partA =: 12 2 machine source

