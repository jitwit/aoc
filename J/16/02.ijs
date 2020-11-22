input=: 'b' freads < '~/code/advent/input/16/2.in'

padA=: 4 9$0 1 2 0 1 2 3 4 5 3 4 5 6 7 8 6 7 8 0 0 1 3 3 4 6 6 7 1 2 2 4 5 5 7 8 8 1 2 2 4 5 5 7 8 8
padB=: 4 13$0 1 0 3 4 1 2 3 8 5 6 7 10 2 5 6 7 4 9 10 11 8 9 12 11 12 0 1 1 2 4 4 5 6 7 9 9 10 12 0 2 3 3 5 6 7 8 8 10 11 11 12
keys=: '123456789ABCD'

step=: 1 : 'for_d. y do. x =. x{m{~''UDLR''i.d end. x'
dial=: 1 : 'num=.''''[dig =. 4 for_n. y do. num=.num,]dig=.dig (m step)>n end. num{keys'

]partA=: padA dial input
]partB=: padB dial input