input=: 'b' freads < '~/code/advent/input/16/7.in'

nets=: [: +/\ (1 _1 0) {~ '[]' i. ]
hypernets=: [: <;._1 (#~ nets)
supernets=: [: <;._1 ']' , (#~ [: -. nets)

abba=: [: +./ 4 ((2=#@~.)*.(-:|.))\ ]
aba=: (<0) -.~ 3 ([: < (0:`])@.((2=#@~.)*.(-:|.)))\ ]
abas=: a:-.~[:,[:>aba&.>

tls=: supernets ([ *. -.)&([: +./ [: > (abba &.> ])) hypernets
ssl=: [:+./[:(([:(1 0 1)&-:i.)&>)/"1 [: ,/ supernets (,"0/ & abas) hypernets

]partA=: +/ > tls &.> input
]partB =: +/ > ssl &.> input