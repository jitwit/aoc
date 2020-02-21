input=: 'b' freads < '~/code/advent/input/16/7.in'

eg1=: 'ioxxoj[asdfgh]zxcvbn'
eg2=: 'aaaa[qwer]tyui[abcd]defg'
eg3=: 'zazbz[bzb]cdc'

NB. chars inside [*]
nets=: [: +/\ (1 _1 0) {~ '[]' i. ]

hypernets=: [: <;._1 (#~ nets)
supernets=: [: <;._1 ']' , (#~ [: -. nets)

abbav=: [: +./ 4 ((2=#@~.)*.(-:|.))\ ]
abba=: adverb : '+./ > ([: +./ 4 ((2=#@~.)*.(-:|.))\ ]) &.> u y'

tls=: supernets abba *. [: -. hypernets abba

]partA=: +/ > tls &.> input

aba=: (<0) -.~ 3 ([: < (0:`])@.((2=#@~.)*.(-:|.)))\ ]
abas=: (<'') -.~ [: , [: > aba &.>

sslv=: ([:(1 0 1)&-:i.) & >
ssl=: [: +./ [: sslv/"1 [: ,/ supernets (,"0/ & abas) hypernets
