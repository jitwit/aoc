load '~/code/aoc/aoc.ijs'

in =: <;._2 aoc 2020 18

NB. reverse string and fix parens so ". works. part A
+/ {{".'('c}')'o}y['o c'=.I.'()'=/y=.|.&.;:y}}&> in

NB. char classes and state table for parsing via ;:
S =: 3 3 2 $ , (". ;. _2)  0 : 0
0 1  1 1  2 1 NB. space
0 3  1 2  2 2 NB. ()*+
0 3  1 2  2 0 NB. number
)
M =: 0;S;(1 I.~(C =: ' ';'()+*')e.&>~])"0 a.

NB. P for parse a parenthesized. tokenizes + calculates depth vector from parens
P =: {{t ,~&<&((0<:p)&#) (+/\-1&=) p =. (;:'()') -/@(=/) t=. M ;: y}}

NB. B for block. evaluate a block of tokens having no nesting. first + then *
B =: {{<":".;(+/\-.+./_1 0|."0 1 y=<,'+')(<@:":@:".@:(;:^:_1))`]@.(1=#)/.y}}

NB. E for eval. evaluate deepest nesting to make progress.
E =: 3 : 0
 if.     1=#y                 do. y
 elseif. 0=d=.>./0{::'D T'=.y do. B T
 else. b =. (2,:2) (B@:{:);._3 T (];.1)~ _1(|.!.1)1,~2~:/\-.m=.d~:D
       (m#D) ;< m#b (I. (T=<,'(') *. (d-1)=D)} T end.
)

+/ ". > E^:_@:P &> in NB. part b
