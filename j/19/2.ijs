require 'tables/csv'

source =: 0{makenum readcsv '../../input/19/2.in'

machine =: 4 : 0
mem =. x (1 2}) y
ip =. 0
while. 1 do.
  select. ip{mem
    case. 1 do. mem =. ( ((1 2+ip) ([:+/{{]) mem)) (((3+ip){mem)}) mem
    case. 2 do. mem =. ( ((1 2+ip) ([:*/{{]) mem)) (((3+ip){mem)}) mem
    case. 99 do. break.
  end.
  ip =. ip + 4
end.
0{mem
)

]partA =: 12 2 machine source

partB =: 3 : 0

)