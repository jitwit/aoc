input=: ". 'm' freads < '~/code/advent/input/16/3.in'

tri=: <`+/@\:~

]partA=: +/ tri"1 input
]partB=: +/ tri"1 ,/_3|:\ input