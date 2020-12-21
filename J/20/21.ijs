load '~/code/aoc/aoc.ijs'
I=:{."1 in=:(<@;:;._2~ e.&'()');._2(aoc 2020 21)-.',' NB. I for ingredient
AL=:~.;A=:}.&.>{:"1 in                                NB. A(L) for allergen
P=: {{>(e.#[)&.>/I#~y&e.&>A}}                         NB. P for poison
+/ ((;I)-.~.;<@P"0 AL)e.;I                            NB. part A
O=: {{(<@;)"1(c{."0 y),.-.&i&.>y[i=.;y#~c=.1=#&>y}}   NB. O for one
}.;','&,&.>(/:AL){;O^:_<@P"0 AL                       NB. part B
