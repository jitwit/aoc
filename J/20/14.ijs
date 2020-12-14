load '~/code/aoc/aoc.ijs'

in =: |. (<;._1~ 'mask'&E.) aoc 2020 14

D =: (36#2)&#: NB. D for decode (36 bits)

blockA =: 3 : 0
 off=. -. {: 'on off'=. '10' =/ mask=. _1 2 {:: y=. |. ;:;._2 y
 (".2{::"1}:y) ,. #. off *."1 on +."1 D ".5{::"1}:y
)

+/ {:"1 (#~ [: ~: {."1) ; blockA &.> in

blockB =: 3 : 0
 off=. -. {: 'on fl' =. '1X' =/ mask=. _1 2 {:: y=. |. ;:;._2 y
 f =. <. 0 ,.~ (#: i. 2^+/fl) +/ . * 2^35-I.fl
 ,/ f +"1/ (#. off *."1 on +."1 D ".2{::"1}:y) ,. ".5{::"1}:y
)

+/ {:"1 (#~ [: ~: {."1) ; blockB &.> in
