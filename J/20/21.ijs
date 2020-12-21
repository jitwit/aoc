load '~/code/aoc/aoc.ijs ~/code/jexp/jexp.ijs'
in =: sexp;._2 (aoc 2020 21)-.','
AL =:~.;A=:{{<}.d#t['d t'=.y}}"1 in                    NB. A(L) for allergens
I =: {{<}:(-.d)#t['d t'=.y}}"1 in                      NB. I for ingredients
P =: {{>(e.#[)&.>/I#~y&e.&>A}}                         NB. P for poison
+/ ((;I)-.(~.;<@P"0 AL))e.(;I)                         NB. part A
O =: {{(<@;)"1(c{."0 y),.(-.&i)&.>y[i=.;y#~c=.1=#&>y}} NB. O for one
}.;','&,&.>(/:AL){;O^:_<@P"0 AL                        NB. part B
