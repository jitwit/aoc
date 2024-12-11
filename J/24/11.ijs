load'~/code/aoc/aoc.ijs'
in =: ({.,#)/.~ ". }: aoc 2024 11
NB. state is a table of stones and counts.
NB. eg. an arrangement of 0 125 0 9 9 9 is represented as:
NB.        0   2
NB.        125 1
NB.        9   3
NB. memoized blink for each stone
S =: 1:`(*&2024)`{{(--:#y)".\y=.":y}}@.{{(*y)*1+1=2|<.10^.0.1+y}} M.
NB. given a table of stones and counts, blink and recount
B =: {{ y =. ; ([:<(0&{::),.(1&{::))"1 (<"0{:"1 y),.~<@S"0 {."1 y
        ({."1 y) ({.@,,{:@(+/))/. y }}
{: +/ B^:25 in
{: +/ B^:75 in
