load 'tables/dsv'
shuffle=:makenum' 'readdsv<'~/code/advent/input/19/22.in'

parse=: 3 : 0
select. 2 {:: y
case. '' do. 2 2 $ 1 , (-1{::y) , 0 1
case. 'increment' do. 2 2 $ (3{::y) , 0 0 1
case. 'new' do. 2 2 $ _1 _1 0 1
end.
)

'a b'=: 0{(+/ .*)/ x:|.parse"1 shuffle
an=: a Mb&|@^]n=: <:Mb-101741582076661x
(Ma | b+a*2019);Mb | (an*2020)+ b*(<:an)*(<:a) Mb&|@^ (Mb-2)
