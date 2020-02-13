load '~/code/advent/code/biblio.ijs'
input=: ". 'm' freads < advent_input 18 1

]partA=: +/ input

expand=: dyad define
freqs=. +/\ 0,,~^: x y
reps=. I. -. ~: freqs
if. 0<#reps do. ({.reps){freqs else. (1+x) expand y end.
)

]partB=: 1 expand input
