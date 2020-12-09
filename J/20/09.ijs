load '~/code/aoc/aoc.ijs'
in=: ". ;._2 aoc 2020 9

P =: 25}.in                                                     NB. P for preamble
]A =: {. P #~ 1 - P e."0 1 }: 25 ([: , [: (*[:</~i.@#) +/~)\ in NB. A for part a
W =: {. 2 + I. {{A e. y+/\in}}"0 ] 2+i._25+#in                  NB. W for width
(>./+<./) , (#~ A=+/"1) W ]\ in                                 NB. part b
