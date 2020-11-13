load '~/code/aoc/aoc.ijs intcode.ijs'

input=: ".;._1}:',',aoc 2019;7

phase =: 3 : 0
 input__a 0,~0{y [ create__a input [ a =. conew 'intcode'
 input__b 1{y [ create__b input [ b =. conew 'intcode'
 input__c 2{y [ create__c input [ c =. conew 'intcode'
 input__d 3{y [ create__d input [ d =. conew 'intcode'
 input__e 4{y [ create__e input [ e =. conew 'intcode'
 machs =. a,b,c,d,e
 Q =. 2 ]\ 0 ,~ i. 5
 while. -. halted__e '' do.
   'mi mo' =. <"0 ({.Q) { machs
   while. 1 do.
     select. step__mi ''
     case. 'halted' do. Q =. }. Q break.
     case. 'blocked' do. Q =. 1 |. Q break.
     case. 'out' do. input__mo output__mi '' end.
   end.
 end. output__e ''
)

>./ phase"1 (i.@! A. i.) 5
>./ phase"1 ] 5 + (i.@! A. i.) 5
