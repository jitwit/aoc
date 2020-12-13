load '~/code/aoc/aoc.ijs'

bez =: 4 : 0
 'a b c d s t' =. 1 0 0 1,x,y
 while. r =. t - s*q =. <. t%s do.
   c =. t [ a =. c-q*a [ t =. a
   d =. t [ b =. d-q*b [ t =. b
   s =. r [ t =. s
 end. a,b,s NB. assert. s = (a*x) + b*y
)

crt =: 4 : 0
 's t g' =. m bez n [ 'b n' =. y [ 'a m' =. x
 (m*n%g) (|,[) (a*n*t) + (b*m*s)
)

'depart ids' =: ];._2 aoc 2020 13
NB. ] 1!:1 < '13.in'
NB. aoc 2020 13
depart =: ". depart
ids =: 0 -.~ xs =: ,".;._1 ',',ids
early =: [ | [: - |

ix =: (i. <./) ids early depart
ts =: ids early depart
ids *&(ix&{) ts

{. crt/ x: ({:"1 ,.~ {:"1 | -@{."1) (#~ 0~:{:"1) (,.~ i.@#) xs
