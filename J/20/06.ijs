load '~/code/aoc/aoc.ijs'

space =: {{' ' (I.LF=y)}y}}
int =: {{ < (>x) #~ (>x) e. (>y) }}
parseA =: {{ # ~. y -. ' ',LF }}
parseB =: {{ # ~. > int/ < ;._1 space y }}
+/ ((parseA,parseB);._2~ (2#LF)&E.) LF,(aoc 2020 6),LF


