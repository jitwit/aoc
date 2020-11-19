load '~/code/aoc/aoc.ijs regex'
msk =: ([: +./'begins'&E.)"1 input =: /:~ ];._2 aoc 2018 4
shifts =: msk <;.1 input
ids =: ~. guards =: 0 ". > _3 {"1 ;: {.&> shifts
NB. only care about minutes after shift begins
naps =: }.@:((15,:2)&(".;.0)"1)

sleep =: guards +//. +/@(_2 (1 = I.&(1+i. 60))\ naps) &> shifts

NB. a is guard who slept most, minute of most sleep * id
a =: (i.>./) +/"1 sleep
]partA =: (a{ids) * (i.>./) a{sleep

NB. b is guard who slept most regularly, minute of most sleep * id
b =: (i.>./) >./"1 sleep
]partB =: (b{ids) * (i.>./) b{sleep
