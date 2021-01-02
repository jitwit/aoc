load '~/code/aoc/aoc.ijs'

PC =: {{2 2 $ 1,(-".1{::y),0 1}}
PI =: {{2 2 $ (".3{::y),0 0 1}}
PN =: {{2 2 $ _1 _1 0 1}}
SEL =: ('';'increment';'new') I. 2&{
P =: PC`PI`PN@.SEL NB. parse

shuffles =: x: |. P"1 ([:<;._1' '&,);._2 aoc 2019 22
'a b'=: {. +/ . */ shuffles
10007|b+a*2019 NB. part A

M =: 119315717514047x
an=: a M&|@^ <:M-101741582076661x

M|(an*2020)+b*(<:an)*(<:a)M&|@^M-2 NB. part B
