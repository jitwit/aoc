load '~/code/aoc/aoc.ijs'

W =: '#'&=;._2 aoc 2020 17

rule =: ([*.=) +. ((-.@[)*.1 2 e.~ ])
nhooda =: (,/ ,/ (,"0 1/ ,"0/~) i:1) -. 0 0 0
pad0 =: 0&, @ ,&0
pada =: (pad0"3) @: (pad0"2) @: (pad0"1)
padb =: (pad0"4) @: (pad0"3) @: (pad0"2) @: (pad0"1)
rule =: ((3=])`(2 3 e.~ ])@.[)

iter =: {{ (rule [: +/ u |.!.0"1 _/ ]) v y }}
+/ , nhooda iter pada ^: 6 ,: W
nhoodb =: (,/,/,/ (,"0 1/ (,"0 1/ ,"0/~)) i:1) -. 0 0 0 0
+/ , nhoodb iter padb ^: 6 ,: ,: W
