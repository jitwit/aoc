load '~/code/aoc/aoc.ijs'

in =: ([: <;._2 ,&LF) &.> (<;._2~ (2#LF)&E.) LF,(aoc 2020 20)
NB. (1!:1 < '20.in'),LF
I =: ([: {: 0 ". ':' -.~ 1&{::) &> in         NB. I for id
N =: %:#B =: ([: > 2&}.) &> in                NB. B for block, N for NxN grid
S =: [: (,|."1) {. , {: , ({.,:{:) @: |:      NB. S for sides
G =: (-=@i.@#) ([: +./ [: , -:"1/~&S)"2/~ B NB. connection graph
*/ I #~ 2 = +/ G NB. part A

mcs =: +/,monster =: '#'&=;._2 ] 0 : 0
                  # 
#    ##    ##    ###
 #  #  #  #  #  #   
)
MM =: mcs=+/@:,@:(monster&*)

C0 =: {. I. 2 = +/ G NB. corner/start
SYM =: (,|:"_1)@:(|:@|.^:(i.4))
X =: SYM"_1 B
H =: {:"2 X
M =: {{ , h #~ ({.y) ~: {."1 h =. 4 $. $. H -:"_2 _ {. X{~<y }}
R =: {{ (#~ ok"2) M^:(i.N)"1 y,.i.8 }}
ok =: (=&# ~.) {."1

NB. fill in sides, deselecting conflicting assignments
T =: {{ r #~ -. +./"1 {."_2 (x-.y) e.~ r =. R y }}
F =: 3 : 0
NB. gets columns. maybe define another thing like R that'll work better here?
F2 =. {."1 {. c0 =. R y
{."_1 (F2&T)"0 F2
)

NB. stitch
ST =: {{if. ({:"1 x) -: {."1 y do. x ,. y else. (|."1 x) ,. y end.}}

NB. sanity check
OK =: 3 : 0
 N <: 1++/ 2 -:/\ y
)

BD =: }.@:}:

IMG =: '#' = ST/ ,"_1/ (-N) ,/"_1\ X {~ <"1 F C0

NB. IMG =: '#' = ,./ ,/ (-N) ,./\ (BD"_1@:BD)"_2 > |."1 |: |."1 <"_2 X {~ <"1 F C0
NB. ,./ ,/ (-N) ,./\ > |."1 |: |."1 <"_2 X {~ <"1 F C0
IMG0 =: '#' = ST/ ,/ (-N) ,./\ > |."1 |: |."1 <"_2 X {~ <"1 F C0
NB. IMG =: '#' = ,./ ,/ (-N) ,./\ (BD"_1@:BD)"_2 > |."1 |: |."1 <"_2 X {~ <"1 F C0
OK IMG0
OK |: IMG0
IMG =: ,./ ,./ (2 2$10) (BD"_1@:BD);._3 IMG0
$ X {~ <"1 F C0
mc =: +/ ,((1 1 ,: $monster)&(MM;._3))"_1 SYM IMG
(+/ ,IMG) - mc *(+/,monster)
