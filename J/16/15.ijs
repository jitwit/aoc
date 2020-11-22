load'~/code/aoc/aoc.ijs'
in =: _1 1 *"1 (+ (0,.~1+i.@#)) <. ". > _1 4 {"1 ;:;._2 aoc 2016 15

bez =: 4 : 0
 'a b c d s t' =. 1 0 0 1,x,y
 while. r =. t - s*q =. <. t%s do.
   c =. t [ a =. c-q*a [ t =. a
   d =. t [ b =. d-q*b [ t =. b
   s =. r [ t =. s
 end. a,b,s assert. s = (a*x) + b*y
)

crt =: 4 : 0
 's t gcd' =. m bez n [ 'b n' =. y [ 'a m' =. x
 (N =. m*n%gcd) (|,[) (a*n*t) + (b*m*s)
)

(_2 0;_1 0) { crt/\ x: in,(-1+#in),11x
