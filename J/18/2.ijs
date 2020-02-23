input=: 'm' freads < '~/code/advent/input/18/2.in'

]partA=: */ +/ (2 3 e./ [: +/ (=/ ~.))"1 input
]partB=: ({. #~ =/) input {~ 0 -.~ ~. , I. 1 = ([:+/-.@=)"1/~ input