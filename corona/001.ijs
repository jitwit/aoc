fetch=: monad define
if. -. fexist'~/code/advent/input/corona/1.in'
do. require 'web/gethttp'
    '-o ~/code/advent/input/corona/' gethttp 'https://ghostbin.co/paste/syjfg/raw'
end.
input=: ".,'m' freads '~/code/advent/input/corona/1.in'
)

NB. in array mask for indices that satisfy requrements based on head.
sat=: <*1=2|-
mask=: {.sat}.

SEQ=: monad define
d=.0#~]n=.#]y=.~.y
g=. (>:i.n) (+&.>) ([:<I.@mask)\. y 
for_v. i.-n do.
  d=. (>: >./ 0,(v{::g){d) v} d
end. d
)

LIST=: [:>: [:>./ [:(#;._2) 0,2 sat/\ ]

]partA=: LIST input
NB. nub and sort. find longest increasing subsequence
]partB=: >./ SEQ /:~ ~. input
