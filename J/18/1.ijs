load '~/code/advent/code/biblio.ijs'
input=: ". 'm' freads < advent_input 18 1

NB. inc number of doublings until enough frequencies are there to find repetition
expand=: monad define
freqs=. +/\ 0,,~^: y input
reps=. I. -. ~: freqs
if. 0<#reps do. ({.reps){freqs else. expand >:y end.
)

]partA=: +/ input
]partB=: expand 1
