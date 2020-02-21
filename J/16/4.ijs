input=: 'b' freads < '~/code/advent/input/16/4.in'

undash=: [:<;._1'-',]
chars=: ' ' -.~ [: , [: > [: }: undash
ordered=: (] (5 {. ] \: [: +/ [ =/ ]) [: /:~ ~.)@:chars
sid_key=: [:(([:".0&{::) ; [:}:1&{::) [:<;._1'[',[:>[:{: undash

analyze=: ordered 0:`(0 {:: ])@.([ -: 1 {:: ]) sid_key

decrypt=: dyad define
letters=. (97+i.26) { a.
(letters{~26|x+]) &.> letters&i. &.> }:<;._1'-',>y
)

room_ids=: > analyze &.> input
rooms=: I. -. 0 = room_ids
messages=: ({&room_ids decrypt"0 {&input) rooms

]partA=: +/ room_ids
]partB=: room_ids {~ rooms {~ I. +/"1 > 'northpole'&-: &.> messages