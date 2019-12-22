load 'tables/dsv'
shuffle=:makenum' 'readdsv<'~/code/advent/input/19/22.in'

parse=: 3 : 0
select. 2 {:: y
case. '' do. 2 2 $ 1 , (-1{::y) , 0 1
case. 'increment' do. 2 2 $ (3{::y) , 0 0 1
case. 'new' do. 2 2 $ _1 _1 0 1
end.
)

invMod =: 4 : 'x y&|@^ <: 5 p: y'"0
n=:<: Mb - 101741582076661x [ Ma=:10007 [ Mb=:119315717514047x
an=: a Mb&|@^ n ['a b'=: 0{(+/ .*)/ x:|.parse"1 shuffle
(Ma | b+a*2019);Mb | (b*(an-1)*(a-1)invMod Mb) + an * 2020
