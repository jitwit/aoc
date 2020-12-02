load '~/code/aoc/aoc.ijs'

parse =: 3 : 0
 'a c' =. ". &.> 0 2 { 'a b c d e' =. ;: y
 (((a&<:)*.(<:&c))+/e={.d) , (1=+/(<:a,c){e={.d)
)

+/ parse;._2 aoc 2020 2
