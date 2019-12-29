require 'tables/dsv'
input =: ')' readdsv < '~/code/advent/input/19/6.in'

NB. S is the edge list converted to ints. R the roots (COM). P the parents.
R=: (i.#planets)-.]P=:1{"1]S=: >planets&i.&.>input[planets=: ~.]orbits=: >,input

path=: (,~[:$:[:0&{[:{&S P&i.)`[@.(e.&R) M.
depth=: <: @ # @ path
lca_depth=: [: {. [: I. -. @: =/ @ ,: & path

orbital_transfers=: +&depth - +:@lca_depth

]partA=: +/ depth"0 i.#planets
]partB=: 'YOU' orbital_transfers&(planets&i.) 'SAN'