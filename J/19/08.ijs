load'~/code/aoc/aoc.ijs'
in =: (-6*25) "."0\ LF -.~ aoc 2019 8

1 2 */@:(+/"_1)@(=/) ({~ (i.<./)@(+/ . =&0)) in    NB. part A
'@ ' {~ _25 -.\ (|: {.@-."_1 2:) in                NB. part B

