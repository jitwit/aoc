load '~/code/aoc/aoc.ijs'
in=: ". ;._2 aoc 2020 9

]A =: {. (#~*) 26 ({: * }: (0 = +./@:e.) {:-}:)\ in
in (>./+<./);.0~ ({:,:-/) {. 4 $. $. A = -/~ +/\ in
NB. slightly faster, more verbose:
NB. in (>./+<./);.0~ ({.,:&{.-~/) I. (+./,:+./"1) A = -/~ +/\ in
