load '~/code/aoc/aoc.ijs'

R =: ;: in =: ];._2 aoc 2020 7                         NB. rules
V =: ~. (<@(;:^:_1)"1) 0 1 {"1 R                       NB. vertices
E =: _2 (<@(;:^:_1)\"1) 5 6 10 11 15 16 20 21 {"1 R    NB. edges
W =: ,/"_1 ". &> (4 9 14 19) {"1 R                     NB. weights/bags
G =: 1 (V i.(,/ E e. V)#,/({.,.~}.)"1 V,.E)}(,~#V)$0   NB. connection graph
gold =: V i. <'shiny gold'

+/ (~:i.@#) gold bfs G                                 NB. part A

B =: 3 : 0 M.                                          NB. lookup bags, memoized
 ws =. msk # ws[xs=.(V i. y{E) #~ msk=. * ws=.y{W
 if. #xs do. 1 + ws +/ . * B"0 xs else. 1 end.
)

<: B gold                                              NB. part B
