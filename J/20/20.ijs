load '~/code/aoc/aoc.ijs'

in =: ([: <;._2 ,&LF) &.> (<;._2~ (2#LF)&E.) LF,aoc 2020 20
I =: ([: {: 0 ". ':' -.~ 1&{::) &> in         NB. I for id
N =: %:#B =: ([: > 2&}.) &> in                NB. B for block, N for NxN grid
S =: [: (,|."1) {. , {: , ({.,:{:) @: |:      NB. S for sides
SYM =: (,|:"_1)@:(|:@:|.^:(i.4))              NB. SYM for block symmetries
H =: {:"2 X =: SYM"_1 B                       NB. H for head? X for?
G =: (-=@i.@#) +./"_1 ([: +./"1 (-:"1/~))/~ H NB. connection graph
*/ I #~ 2 = +/ G NB. part A

C0 =: {. I. 2 = +/ G NB. corner/abritrary start
M =: {{ , h #~ ({.y) ~: {."1 h =. 4 $. $. H -:"_2 _ {. X{~<y }}
R =: {{ (#~ ((=&# ~.) {."1)"2) M^:(i.-N)"1 y,.i.8 }}

T =: {{ r #~ -. +./"1 {."_2 (x-.y) e.~ r =. R y }}
NB. dumb hacky stitch (side by side agreement)
ST =: {{if.({:"1 x)-:{."1 y do. x,.y else. (|."1 x),.y end.}}
SEA =: {{IMG=.ST/,/"_1 X{~<"1{."_1(F2&T)"0 F2=.{."1{.R y
         '#'=,./^:2(2 2$10)(}.@:}:"_1@:}.@:}:);._3 IMG}}
SMC =: +/,SM =: '#'&=;._2 ] 0 : 0 NB. sea monster
                  # 
#    ##    ##    ###
 #  #  #  #  #  #   
)

(+/,IMG)-SMC*+/,((1 1,:$SM)&(SMC=+/@:,@:(SM&*);._3))"_1 SYM SEA C0
