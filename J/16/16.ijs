]input=: ,'1'='m' freads <'~/code/advent/input/16/16.in'

iter=: ,0,|.@:-.
dragon=: ([$:iter@])`{.@.([<#@])
checksum=: ([:$:_2=/\])`([:,[:":"0])@.(2|#)

]partA=: checksum 272 dragon input
]partB=: checksum 35651584 dragon input