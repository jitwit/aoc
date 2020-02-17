load '~/code/advent/code/biblio.ijs tables/dsv'
input=: ' 'readdsv<advent_input 15 14
race=: +/\|:2503([$((1{])#0{]),0#~2{])"_ 1>".L:0]3 6 13{&.|:input
]partA=: >./{:race
]partB=: >./+/(= >./)"1 race
