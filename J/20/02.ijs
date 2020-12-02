load '~/code/aoc/aoc.ijs'

parse =: 3 : 0
 'a b c d e' =. ;: y
 'a c' =. ". &.> a;c
 parta =. ((a&<:)*.(<:&c)) +/ ({.d) = e
 parta , 1=+/(<:a,c){({.d) = e
)

+/ parse;._2 aoc 2020 2
