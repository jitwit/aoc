require 'tables/dsv'
input =: ')' readdsv < '~/code/advent/input/19/6.in'

R=: (i.#planets)-.]P=:1{"1]S=: >planets&i.&.>input[planets=: ~.]orbits=: >,input
path=: (,~[:$:[:0&{[:{&S P&i.)`[@.(e.&R) M.
orbital_transfers=: (+&(<:@#) - +:@([:{.[:I.-.@=/@,:))&path

]partA=: +/ <: #@path"0 i.#planets
]partB=: 'YOU' orbital_transfers&(planets&i.) 'SAN'