require 'tables/dsv'
input =: ')' readdsv < '~/code/advent/input/19/6.in'

NB. S is the edge list converted to ints. R the roots (COM). P the parents.
R=: (i.#planets)-.]P=:1{"1]S=: >planets&i.&.>input[planets=: ~.]orbits=: >,input
path=: (,~[:$:[:0&{[:{&S P&i.)`[@.(e.&R) M.

orbital_transfers=: 4 : 0
n=.A(<.&#)]B=. }:path planets i.y[A=. }:path planets i.x
l=.{.I.(-.(n{.A)=(n{.B))
(A(+&#)B)-+:l
)

]partA=: +/ (<:@#@path)"0 i.#planets
]partB=: 'YOU' orbital_transfers 'SAN'
