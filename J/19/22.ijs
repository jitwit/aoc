load 'tables/dsv'
insts=:makenum' 'readdsv<'~/code/advent/input/19/22.in'

parse=: 3 : 0
select. 2 {:: y 
case. '' do. 2 2 $ 1 , (-1{::y) , 0 1
case. 'increment' do. 2 2 $ (3{::y) , 0 0 1
case. 'new' do. 2 2 $ _1 _1 0 1
end.
)

invMod =: 4 : 'x y&|@^ <: 5 p: y'"0
n=:<: mb - 101741582076661x [ ma=:10007 [ mb=:119315717514047x
an=: a mb&|@^ n [ 'a b'=: 0{]shuffle=: (+/ .*)/x:|.parse"1 insts
]partA=: ma | b+a*2019
]partB=: mb | (b*(an-1)*(a-1)invMod mb) + an * 2020

