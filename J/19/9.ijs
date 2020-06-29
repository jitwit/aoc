load'~/code/aoc/aoc.ijs'
input=: ".;._1}:',',aoc 2019;9
NB. freads<'~/code/advent/input/19/9.in'

intcode=: monad define
0;0;'';'';y,(1100-(#y)) # 0
)

NB. x is opcode & param, y is memory
ref=: dyad define
'ip rp in out prog'=. y
select. 10|<.(ip{prog)%10^1+x
case. 0 do. prog {~ prog {~ ip+x
case. 1 do. prog {~ ip+x
case. 2 do. prog {~ rp+prog {~ ip+x
end.
)

addr=: dyad define
'ip rp in out prog'=. y
select. 10|<.(ip{prog)%10^1+x
case. 0 do. prog {~ ip+x
case. 2 do. rp+prog {~ ip+x
case. 1 do. ip+x
end.
)

step=: monad define
'ip rp in out prog'=. y
select. op=.100|ip{prog
case. 1 do. ip=. ip+4 [ prog=. (+/ 1 2 ref"0 _ y) (3 addr y)} prog
case. 2 do. ip=. ip+4 [ prog=. (*/ 1 2 ref"0 _ y) (3 addr y)} prog
case. 3 do. if. #in do. ip=. ip+2 [ in=.}.in [ prog=. ({.in) (1 addr y)} prog end.
case. 4 do. ip=. ip+2 [ out=. out,1 ref y
case. 5 do. if. 1 ref y do. ip=. 2 ref y else. ip=. ip+3 end.
case. 6 do. if. 0 = 1 ref y do. ip=. 2 ref y else. ip=. ip+3 end.
case. 7 do. ip=. ip+4 [ prog=. ((1 ref y) < (2 ref y)) (3 addr y)} prog
case. 8 do. ip=. ip+4 [ prog=. ((1 ref y) = (2 ref y)) (3 addr y)} prog
case. 9 do. ip=. 2+ip [ rp=. rp + 1 ref y
end. ip;rp;in;out;prog
)

put_in=: dyad define
'ip rp in out prog'=. y
ip;rp;(in,x);out;prog
)

get_out=: 3&{::

machine=: intcode input

]partA=: get_out step ^: _ ] 1 put_in machine
]partB=: get_out step ^: _ ] 2 put_in machine