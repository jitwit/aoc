load '~/code/aoc/aoc.ijs plot'

ids =: #. (e.&'BR') ;._2 aoc 2020 5
(>./,(-.~ <./ + [: i. >./ - <./)) ids
