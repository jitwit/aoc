in =: ];._2 aoc 2024 4

S =: 'XMAS'&E."1                           NB. searching for XMAS
S0 =: +/@:,@:S
S1 =: +/@:,@:(S &.|."1)
S2 =: +/@:,@:S &. |:
S3 =: +/@:,@:S &. (|."1@|:)
D =: 'XMAS'&E."1/.                         NB. search on diagonals
D0 =: +/@:,@:D
D1 =: +/@:,@:D &. |.
D2 =: +/@:,@:D &. |:
D3 =: +/@:,@:D &. (|."1@|:)

(S0+S1+S2+S3+D0+D1+D2+D3) in               NB. part A

XMAS =: 'SSAMM','MMASS','MSAMS',:'SMASM'
X =: XMAS e.~ 0 2 4 6 8 { ,

+/,(1 1,:3 3) X;._3 in                     NB. part B
