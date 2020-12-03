load '~/code/aoc/aoc.ijs'
in =: '#'&=;._2 aoc 2020 3

trees =: [: +/ ] {~ [: <"1 $@] |"1 [ */~ [: i. [: <. {.@$@] * 1<.%~/@[

1 3 trees in
*/ _2 (trees&in)\ 1 1 1 3 1 5 1 7 2 1
