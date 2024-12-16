load'~/code/aoc/aoc.ijs'
in =: "."0;._2 aoc 2024 10
NB. code is adapted from my J boggle solver: https://github.com/jitwit/joggle
G =: [:<@-.&_1"1@|:[:;"_1(+.(*&0j1)^:(i.4)0j1)|.!._1 i.   NB. reified graph of grid
A =: [ ,"_ 0/ [ -.~ ] {::~ {:@:[                          NB. possible expansions
E =: {{([:(#~(-:i.@#)"_1@:({&u))[:;<@(A&v)"1)^:(0<#)&.>}} NB. expand trails
S =: {{ (,y) E (G$y) ^: 9 <,.i.#,y }}                     NB. search for trails
+/ ({."1 T) #@~.@:({:"1)/. T =: > S in                    NB. part A
+/ ({."1 T) #@~./. T                                      NB. part B
