load '~/code/advent/code/biblio.ijs'

choices=: #:i.2^#]input=:".'m'freads<advent_input 15 17

eggnog=: I. 150 = choices +/ .* input
]partA=: # eggnog
]partB=: +/ (= <./) +/"1 eggnog { choices
