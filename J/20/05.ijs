load '~/code/aoc/aoc.ijs plot'

ids =: #. (e.&'BR') ;._2 aoc 2020 5
>./ ids
({~ [: {: @ I. 1 ~: 2-~/\]) (i.2^10)-.ids
