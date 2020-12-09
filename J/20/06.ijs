load '~/code/aoc/aoc.ijs'

az=: a.{~97+i.26
in=: LF,(aoc 2020 6),LF
+/"1 +/ ((+./,:*./)@:(az&e.;._1);._2~ (2#LF)&E.) in
