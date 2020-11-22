load '~/code/aoc/aoc.ijs'

elves =: 1+i.".;._2 aoc 2016 19

{{_1 |.^:(2|#y) _2 {.\ y}}^:_ elves
{{(#g)|.y{~(i.l)-.g=.(g I.l){.g=.(+:+[:<.[:-:l&-)i.<.-:l=.#y}}^:_ elves

