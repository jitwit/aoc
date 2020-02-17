load '~/code/advent/code/biblio.ijs'

in=:".'m'freads<advent_input 15 17

nog=: #:I.150=(#:i.2^#in) +/ .* in

]partA=: # nog
]partB=: +/ (= <./) +/"1 nog