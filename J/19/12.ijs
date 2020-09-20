load '~/code/aoc/aoc.ijs'
moons =: (,:0:"0) 0&".;._2 '<>xyz=,' -.~ aoc 2019 12

dv =: +/@:*@(-"1/~)@{.
D =: (+"_1 _ dv) + 1|.!.0]
E =: +/ @: (*&(+/@,@:|)"1/)
A =: [: ,."_1 [ ({"_1) 1|:]
P =: 1 : 'D^:([: -. u&-:)^:a:'
Pi =: 4 : '# (x A y) P D x A y'

]partA=: energy step^:1000 ms
]partB=: *./ (i.3) Pi"0 _/ moons
