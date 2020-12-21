load '~/code/aoc/aoc.ijs'
I=:{."1 in=:(<@;:;._2~ e.&'()');._2(aoc 2020 21)-.','  NB. I for ingredient
P=:{{(e.#[)&.>/I#~y&e.&>A}}"0 AL=:~.;A=:}.&.>{:"1 in   NB. P for poison A(L) for allergen
+/-.(;I)e.~.;P                                         NB. part A
O =: {{(<@;)"1(c{."0 y),.-.&i&.>y[i=.;y#~c=.1=#&>y}}   NB. O for one
}.;','&,&.>(/:AL){;O^:_ P                              NB. part B
