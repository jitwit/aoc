load '~/code/aoc/aoc.ijs'

W =: '#'&=;._2 aoc 2020 17

pad0 =: 0&, @ ,&0
pada =: (pad0"3) @: (pad0"2) @: (pad0"1)
padb =: (pad0"4) @: (pad0"3) @: (pad0"2) @: (pad0"1)

nhooda =: (,/^:2(,"0 1/ ,"0/~)i:1) -. 0 0 0
nhoodb =: (,/^:3(,"0 1/^:2 ,"0/~)i:1) -. 0 0 0 0
rule =: ((3=])`(2 3 e.~ ])@.[)

life =: {{ (rule [: +/ u |.!.0"1 _/ ]) v y }}

+/ , nhooda life pada ^: 6 ,: W
+/ , nhoodb life padb ^: 6 ,:^:2 W
