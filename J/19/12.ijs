load '~/code/aoc/aoc.ijs ~/code/J-esquisse/kde.ijs'
moons =: (,:0:"0) 0&".;._2 '<>xyz=,' -.~ aoc 2019 12

dv =: +/@:*@:(-"1/~)@:{.
D =: (+"_1 _ dv)+1|.!.0]
E =: +/@:(*&(+/@:,@:|)"1/)
P =: 1 : 'D^:([: -. u&-:)^:a:'
Pi =: 4 : '# mi P D mi=. (($,1:)$,) x {"_2 y'

]partA=: E D^:1000 moons
]partB=: (i.3) *./@:(Pi"0 _) moons
