load '~/code/aoc/aoc.ijs'
in =: ([:<;._1'-',]);._2 aoc 2021 12

NB. inspired by boggle solver
Vb =: I.-.([:*./e.&az) &> V =: ~.,in NB. vertices and "large vertices"
G =: {:"1 &.> (</.~ {."1) /:~ (,|."1) V i. in
v1 =: V i. (<'end')[v0 =: V i. (<'start')
A =: {{ y,"_ 0/({:y){::G }}"1 NB. adjacent .... finds adjacent vertices on a:
F =: {{ (-.v1 e.}:y) *. 2 > >./ #/.~ y-.Vb }} NB. filter invalid paths
P =: #~v1={:"1 NB. filter that path ends at end vertex
go =: {{ < (#~ F"1) ; (<@A) >y }} ^: (~:&a:)
go^:a: < ,:^:2 v0
+/(#@P) &> go^:a: < ,:^:2 v0
NB. start end only once, a single small cave twice. new filter
F =: {{ (1=+/v0=y) *. (-.v1 e.}:y) *. *./ 2 1 >: 2 {.!.0 \:~ #/.~ y-.Vb }}
+/(#@P) &> go1^:(a:) < ,:^:2 v0
