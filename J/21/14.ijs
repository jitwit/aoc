load '~/code/aoc/aoc.ijs'
xs =: <;._2 aoc 2021 14
P =: {{ s ; ({.s),({:y),{: s =. 2{.y }} NB. parsing
S =: >{.xs [ 'A B' =: |: P &> 2 }. xs NB. A = before, B = after, S = start
Y =: <: #/.~ (i.#A) , /:~ A i. 2 ]\ S NB. initial pair count
T =: ([: <: [: #/.~ (i.#A),])"_1 A i. (2]\])"_1 B NB. table of reaction counts
T0 =: ([: <: [: #/.~ (i.#C),])"_1 (C =: ~.,B) i. {:"1 A NB. table of char counts
R =: {{ ({:-{.) /:~ (X0 C i. {.S) + +/ /:~ T0 * (+/ @: *&T)^:y Y }} NB. reaction
R"0 ] 10 40 NB. part A & B
