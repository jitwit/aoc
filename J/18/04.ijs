load '~/code/aoc/aoc.ijs regex'
NB. setup/getting guard ids. can just sort lexicographically because
NB. of how times are presented.
shifts=: input <;.1~ msk=: ([:+./'begins'&E.)"1 input=: /:~ ];._2 aoc 2018 4
ids=: ~. guards=: 0 ". > _3 {"1 ;: {.&> shifts

NB. only care about minutes after shift begins, alterates sleep/awake
naps =: [: +/ _2 (1 = I.&(1+i.60))\ (1 15,:_ 2)&(".;.0)
sleep =: guards +//. naps &> shifts

NB. a is guard who slept most, minute of most sleep * id
a =: (i.>./) +/"1 sleep
]partA =: (a{ids) * (i.>./) a{sleep

NB. b is guard who slept most regularly, minute of most sleep * id
b =: (i.>./) >./"1 sleep
]partB =: (b{ids) * (i.>./) b{sleep
