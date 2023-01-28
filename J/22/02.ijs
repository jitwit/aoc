load '~/code/aoc/aoc.ijs'
R =: |: _2 ]\ 23 | 65 -~ 10 32 -.~ a. i. in =: aoc 2022 2
S =: +/@:>:@:{: + 3+/ .*3|1+(-~/) NB. score results
S R
S ({. ,: 3|{.+<:@:{:) R
