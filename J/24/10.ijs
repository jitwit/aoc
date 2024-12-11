load'~/code/aoc/aoc.ijs'
in =: "."0;._2 aoc 2024 10

W =: ,-:(i. 10)                                          NB. full trail?
P =: (-:i.@#)                                            NB. trail prefix
G =: [:<@-.&_1"1@|:[:;"_1(+.(*&0j1)^:(i.4)0j1)|.!._1 i.  NB. reified graph of grid
A =: [ ,"_ 0/ [ -.~ ] {::~ {:@:[                         NB. possible expansions
E =: {{([:(#~P"_1@:({&u))[:;<@(A&v)"1)^:(0<#)&.>}}       NB. expand trails
S =: {{ (,y) E (G$y) ^: 9 <,.i.#,y }}                    NB. search for trails
T =: > S in                                              NB. all trails
+/ ({."1 T) #@~.@:({:"1)/. T                             NB. part A
+/ ({."1 T) #@~./. T                                     NB. part B
