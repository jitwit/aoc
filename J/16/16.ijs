load'~/code/advent/code/biblio.ijs'
]input=: ,'1'='m' freads <'~/code/advent/input/16/16.in'

iter=: ,0,|.@:-.
build=: ([$:iter@])`{.@.([<#@])
checksum=: ([:$:_2=/\])`([:,[:":"0])@.(2|#)
dragon=: [: checksum build

]partA=: 272 dragon input
]partB=: 35651584 dragon input


