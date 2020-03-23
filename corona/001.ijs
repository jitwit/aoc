fetch=: monad define
if. -. fexist'~/code/advent/input/corona/1.in'
do. require 'web/gethttp'
    '-o ~/code/advent/input/corona/' gethttp 'https://ghostbin.co/paste/syjfg/raw'
end.
input=: ".,'m' freads '~/code/advent/input/corona/1.in'
)

NB. in array mask for indices that satisfy requrements based on head.
mask=: {.<}. *. (2|>:@{.) = 2|}.

NB. d is distance vector. d[i] will hold length of longest satisfying
NB. subsequences after index i. graph g. edge u->v is in g when u and
NB. v are different mod 2, u<v, and y[u] < y[v]. for each vertex from
NB. the end, set the longest increasing subsequence with i to minimum
NB. of those of i's out edges in g.
SEQ=: monad define
y=.~.y NB. nub
n=.#y
d=.n#0 NB. d initially 0
g=. (>:i.n) ([+&.>]) ([:<I.@mask)\. y 
for_e. i.-n do.
  d=. (1 >. >: >./(e{:: g){d) (e}) d
end. d
)

NB. instead of looking at all possible subsequences, look for
NB. satisfying conecutive lists of length 2. find longest block of 1s
NB. by scanning with + and resetting on 0s ((+**@[) is used to
NB. accomplish this) finally find maximum and add by 1.
LIST=: [: >: [: >./ [: (+**@[)/\. 2 mask\ ]

]partA=: LIST input
NB. nub and sort. find longest increasing subsequence
]partB=: >./ SEQ /:~ ~. input
