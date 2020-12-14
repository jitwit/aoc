load '~/code/aoc/aoc.ijs'

in =: |. (<;._1~ 'mask'&E.) aoc 2020 14

W =: #~ [: ~: {."1
D =: (36#2)&#:

blockA =: 3 : 0
 mask =. _1 2 {:: y =. |. ;:;._2 y
 off =. -. off [ 'on off' =. '10' =/ mask
 adds =. ". 2 {::"1 }: y
 adds ,. #. off *."1 on +."1 D ". 5 {::"1 }: y
)

+/ {:"1 W ; blockA &.> in

blockB =: 3 : 0
 mask =. _1 2 {:: y =. |. ;:;._2 y
 off =. -. float [ 'on float' =. '1X' =/ mask
 j =. (#. off *."1 on +."1 D ". 2 {::"1 }: y) ,. ". 5 {::"1 }: y
 f =. (#: i. 2^+/float) +/ . * 2^35-I.float
 ,/ (f,.0) +"1/ j
)

<. +/ {:"1 W ; blockB &.> in
