load '~/code/aoc/aoc.ijs'

in =: '.L#'&i. ;._2 aoc 2020 11
F =: (0=])`(4>])@.[ [: +/ (<:3 3#:(i.9)-.4)|.!.0/ ]
S =: in * 1 + F @: (2&=) f.

+/ , 2 = S ^: _ in

Z =: [: < 2 <\ (#~ {&in)
I =: ~. {."1 E =: (,|."1) >;(Z/.J),(Z/.|.J),Z"1 J,|:J =: {;~i.#in
ES =: E ([:<{:"1)/.~ {."1 E
VI =: {{ (([: +/ {&y) &> ES) I} y }}
G =: (0=])`(5>])@.(2=[) (VI@:(2&=))
T =: in * 1 + G f.

+/ , 2 = T ^: _ in
