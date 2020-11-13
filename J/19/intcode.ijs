coclass 'intcode'

create =: 3 : 0
 ip =: rp =: 0
 in =: out =: ''
 program =: y , (1100-(#y)) # 0 NB. giving some extra space.......
)

ref=: 3 : 0"0
 select. 10|<.(ip{program)%10^1+y
 case. 0 do. program {~ program {~ ip+y
 case. 1 do. program {~ ip+y
 case. 2 do. program {~ rp+program {~ ip+y
 end.
)

addr=: 3 : 0
 select. 10|<.(ip{program)%10^1+y
 case. 0 do. program {~ ip+y
 case. 2 do. rp+program {~ ip+y
 case. 1 do. ip+y
 end.
)

opcode =: 3 : '100|ip{program'
halted =: 99 = opcode

step =: 3 : 0
 select. 100|ip{program
 case. 1 do. ip=: ip+4 [ program=: (+/ ref 1 2) (addr 3)} program
 case. 2 do. ip=: ip+4 [ program=: (*/ ref 1 2) (addr 3)} program
 case. 3 do. if. #in do. program=: ({.in) (addr 1)} program
                         in =: }. in
			 ip =: ip + 2 end.
 case. 4 do. ip=: ip+2 [ out=: out,ref 1
 case. 5 do. if. ref 1 do. ip=: ref 2 else. ip=: ip+3 end.
 case. 6 do. if. 0 = ref 1 do. ip=: ref 2 else. ip=: ip+3 end.
 case. 7 do. ip=: ip+4 [ program=: ((ref 1) < (ref 2)) (addr 3)} program
 case. 8 do. ip=: ip+4 [ program=: ((ref 1) = (ref 2)) (addr 3)} program
 case. 9 do. ip=: 2+ip [ rp=: rp + ref 1 end.
)

run =: 3 : 0
 whilst. 1 do.
  select. op=.100|ip{program
  case. 1 do. ip=: ip+4 [ program=: (+/ ref 1 2) (addr 3)} program
  case. 2 do. ip=: ip+4 [ program=: (*/ ref 1 2) (addr 3)} program
  case. 3 do. if. #in do. program=: ({.in) (addr 1)} program
                          in =: }. in
 			 ip =: ip + 2
	      else. break. end.
  case. 4 do. ip=: ip+2 [ out=: out,ref 1
  case. 5 do. if. ref 1 do. ip=: ref 2 else. ip=: ip+3 end.
  case. 6 do. if. 0 = ref 1 do. ip=: ref 2 else. ip=: ip+3 end.
  case. 7 do. ip=: ip+4 [ program=: ((ref 1) < (ref 2)) (addr 3)} program
  case. 8 do. ip=: ip+4 [ program=: ((ref 1) = (ref 2)) (addr 3)} program
  case. 9 do. ip=: 2+ip [ rp=: rp + ref 1
  case. 99 do. break. end.
 end.
)
