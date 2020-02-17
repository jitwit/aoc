load '~/code/advent/code/biblio.ijs'
grid=: '#' = 'm' freads < advent_input 15 18

small=: 6 6 $ '#' = '.#.#.#...##.#....#..#...#.#..#####..'

step=: (3=])`(e.&3 4)@.["0 0[:+/^:2(,"0/~i:1)&(|.!.0)
mask=: 3 : '1 (,/,"0/~(0,<:#y))} ($y) $ 0'
stick=: mask +. step

]partA=: +/^:2 step^:100 grid
]partB=: +/^:2 stick^:100 (+. mask) grid