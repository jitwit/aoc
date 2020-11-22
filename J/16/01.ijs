input=: dltb&.>','cut',',~freads < '~/code/advent/input/16/1.in'

dirs=: [:}.[:*/\[:0j1&,[:{&(0j1 0j_1)[:>'LR'&i.@{.&.>
steps =: 3,~[:".[:}:[:>}.&.>
path=: +/\ (dirs*steps) input

l1=: [:+/[:|9 11 o./]
dz=: {.+((]%|)*[:i.|)&([:--/) NB. fill in steps between two points in C

]partA=: l1 {: path
]partB=: l1 ([:{.]{~[:I.[:-.~:) 0-.~, 2 dz\ path