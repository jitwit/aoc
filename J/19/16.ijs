load'~/code/aoc/aoc.ijs'

digits=: "."0 }: aoc 2019;16

pat=: ([:}.>:@[$0 1 0 _1#~])"_ 0 >:@i.
off=: (10#.7{.]) }. ($~10000*#)

ffta=: 10 #. 8 {. pat@# (10 | [: | (+/ .*))^:100 ]
fftb=: 10 #. 7 {. [: (10 | +/\.)^:100 off

]partA=: ffta digits
]partB=: fftb digits
