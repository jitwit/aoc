load '~/code/aoc/aoc.ijs'
parse =: 'BF'
parse =: 'LR'

row =: {{ #. 'B' = 7 {. y }}
seat =: {{ #. 'R' = _3 {. y }}
parse =: seat + 8*row
parse
#'FBFBBFFRLR'

,. (i.1024) -. (seat + 8*row);._2 aoc 2020 5
