load '~/code/aoc/aoc.ijs regex'

in =: (<;._2~ (2#LF)&E.) LF,~aoc 2020 19
Q =: {{ (r=_) {:: y;r=._".y }}
P =: [: (([: }.&.>{.),}.) [: <@".;._1'|',]
O =: /: ". > {."1 ([: <;._1 ' ',]);._1 ] (#~ ~:&':') LF,0{::in
S =: <;._1 ] 1{::in
R =: O { ];._1 LF,0{::in

F =: 3 : 0 M.
 r=.(2+r i.':')}.r=.r#~-.*./\.' '=r=.(y{R)-.'"'
 if. r e. 'ab' do. '(',r,')'
 else. g =. ([: ; <@F"0) &.> <@".;._1 '|',r
       '(',(}. ; ('|'&,) &.> g),')'
 end.
)

G =: 3 : 0 M.
 r=.(2+r i.':')}.r=.r#~-.*./\.' '=r=.(y{R)-.'"'
 if. r e. 'ab' do. '(',r,')'
 elseif. y = 8 do. (G 42),'*'
 elseif. y = 11 do. g42 =. G 42
 	     	    g31 =. G 31
		    g42,g31
		    NB. todo
 else. g =. ([: ; <@G"0) &.> <@".;._1 '|',r
       '(',(}. ; ('|'&,) &.> g),')'
 end.
)


rea =. rxcomp '^',(F 0),'$'
# rea&rxall > {: in
NB. reb =. rxcomp '^',(G 0),'$'
NB. # reb&rxall > {: in

