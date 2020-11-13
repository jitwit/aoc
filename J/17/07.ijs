load '~/code/aoc/aoc.ijs regex'

in =: aoc 2017 7
1!:1 < '7.small' NB. 

let =: [: < '[[:lower:]]+'&rxall
wgt =: [: ". [: ; '[[:digit:]]+'&rxall
V =: i. # ids =: {. & > gph =: let ;._2 in
G =: ids i. ; (}. ,. {.) &.> gph
T =: ({:"1 G) ({."1 G) } V
W =: wgt ;._2 in
P =: {&T
D =: _1+#@~."1 @: |: @: (P ^: a:)

partA =: ids #~ V = P V

bal =: 3 : 0
a =. (#V) $ 0
for_v. (\: D) V do. wv =. v { W [ ws =. a {~ vs =. ids i. }. v {:: gph
  if. 1 < # ~. ws do. ({.+-/) 1 {"1 \:~ (#,{.)/.~ ws return.
  end. a=. (wv + +/ws) v} a
end.
)

partA , partB =: < bal ''
