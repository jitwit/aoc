load '~/code/aoc/aoc.ijs'
in =: |: ;:;._2 aoc 2021 2
dir =: ;: 'forward down up'

del =: ". > {: in
mov =: (_2 ]\ 1 0 0 1 0 _1) {~ dir i. {. in
*/ +/ del * mov

partB =: 3 : 0
 aim =. 0
 dep =. 0
 hor =. 0
 for_ij. |: in do.
   j =. ". > j ] 'i j' =. ij
   select. >i
   case. 'up' do. aim =. aim - j
   case. 'down' do. aim =. aim + j
   case. do. dep =. dep + j * aim
             hor =. hor + j
   end.
 end. dep*hor
)

partB ''

