load '~/code/aoc/aoc.ijs'
in =: ] ;._2 aoc 2024 8

V =: 4 $. $. '.' ~: in
B =: #~[:*./"1(($in)&>"1*.0 0&<:"1)                     NB. filter in bounds
A0 =: {{ if. x -: y do. a: else. < B (x,:y)-.~(y-w),(y+w),(x-w),:x+w=.y-x end. }}
A1 =: [: ~. [: ,/^:2 A0"1/~
{.$ ~. ; a: -.~ , A1 &> ((<"1 V){in) </. V

A2 =: {{ if. x -: y do. a: else. < B (y+"1 ws),x+"1 ws=.(i:{.$in)*/w=.y-x end. }}
A3 =: [: ~. [: ,/^:2 A2"1/~
{.$~.;a:-.~, A3 &> ((<"1 V){in) </. V
