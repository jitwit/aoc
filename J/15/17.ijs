load '~/code/advent/code/biblio.ijs'

input=:".'m'freads<advent_input 15 17

eggnog=: #: I. 150 = (#:i.2^#input) +/ .* input

]partA=: # eggnog
]partB=: +/ (= <./) +/"1 eggnog
