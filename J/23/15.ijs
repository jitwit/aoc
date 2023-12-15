load '~/code/aoc/aoc.ijs'
in =: aoc 2023 15
NB. +/H;._2 'rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7,'
H =: [: (256|17*+)/ [: |. 0,a.&i.
+/ H;._2 (in-.LF),','
