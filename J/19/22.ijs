shuffle=: |. parse"1 ([:<;._1' '&,);._2 freads<'~/code/advent/input/19/22.in'
Ma=:10007 [ Mb=:119315717514047x

parse=: monad define
select. 2{::y
case. '' do. 2 2 $ 1,(-".1{::y),0 1
case. 'increment' do. 2 2$(".3{::y),0 0 1
case. 'new' do. 2 2$_1 _1 0 1
end.
)

'a b'=: {. (+/ .*)/ x: shuffle
]partA=:Ma|b+a*2019

an=:a Mb&|@^<:Mb-101741582076661x
]partB=:Mb|(an*2020)+b*(<:an)*(<:a)Mb&|@^Mb-2
