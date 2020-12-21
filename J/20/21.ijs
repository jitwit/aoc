load '~/code/aoc/aoc.ijs ~/code/jexp/jexp.ijs'

in =: sexp;._2 (aoc 2020 21)-.','

AL =: ~. ; A =: {{ < }. d # t [ 'd t' =. y }}"1 in
I =: {{ < }: (-.d) # t [ 'd t' =. y }}"1 in

P =: {{ > (e.#[)&.>/ I #~ y&e. &> A }}
+/ ((;I)-.(~. ; <@P"0 AL)) e. (;I)

one =: {{ (<@;)"1 (c{."0 y) ,. (-.&i) &.> y [ i =. ; y #~ c =. 1 = # &> y }}
}. ; ','&, &.> (/: AL) { ; one^:_ <@P"0 AL


