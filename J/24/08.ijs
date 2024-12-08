load '~/code/aoc/aoc.ijs'
in =: ] ;._2 aoc 2024 8

V =: (<"1 V{in)</.V =. 4 $. $. '.' ~: in             NB. antennae
B =: #~[:*./"1(($in)&>"1*.0 0&<:"1)                  NB. filter in bounds
A0 =: {{<B(x,:y)-.~(y+"1 ws),x+"1 ws=._1 1*/w=.y-x}} NB. single hop antipodes
A =: {{ [: ~. [: ,/^:2 u"1/~ }}                      NB. calculate antipode based on u
{.$~.; a:-.~,A0 A &> V                               NB. part A

A1 =: {{<B(y+"1 ws),x+"1 ws=.(i:{.$in)*/w=.y-x}}     NB. multi hop antipodes
{.$~.;a:-.~, A1 A &> V                               NB. part B
