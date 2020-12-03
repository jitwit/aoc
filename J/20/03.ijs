load '~/code/aoc/aoc.ijs'
trees =: '#'&=;._2 aoc 2020 3

ski =: [: +/ ] {~ [: <"1 $@] |"1 i.@>.@(%~&{.$@]) */ [
1 3 ski trees
*/ _2 (ski&trees)\ 1 1  1 3  1 5  1 7  2 1

