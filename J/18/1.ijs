load '~/code/aoc/aoc.ijs'
input=: (0&".);._2 aoc 2018;1

NB. inc number of doublings until enough frequencies are there to find repetition
expand=: monad define
freqs=. +/\ 0,,~^: y input
reps=. I. -. ~: freqs
if. 0<#reps do. ({.reps){freqs else. expand >:y end.
)

]partA=: +/ input
]partB=: expand 1
