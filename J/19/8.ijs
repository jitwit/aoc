load'~/code/aoc/aoc.ijs'
image =: (-6*25) "."0\ LF -.~ aoc 2019 8

]partA =: 1 2 */@:(+/"_1)@(=/) ({~ (i.<./)@(+/ . =&0)) image
]partB =: '@ ' {~ _25 -.\ (|: {.@-."_1 2:) image

