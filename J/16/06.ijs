input=: |: 'm' freads < '~/code/advent/input/16/6.in'

letters=: /:~ ~. , input

analyze=: adverb define
letters {~ (i. u) +/"1 letters =/ y
)

]partA=: >./ analyze"1 input
]partB=: <./ analyze"1 input