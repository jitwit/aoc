load'~/code/advent/code/biblio.ijs'
input=: ". 'm' freads < advent_input 16 3

tri=: <`+/ @ \:~

]partA=: +/ tri"1 input
]partB=: +/ tri"1 ,/_3|:\ input
