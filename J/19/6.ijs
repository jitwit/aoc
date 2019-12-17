require 'tables/dsv'
input =: ')' readdsv < '~/code/advent/input/19/6.in'

orbits =: > , input
planets =: ~. orbits
solar_system =: 1 (_2<\planets i. orbits)} 1 $. (2$#planets);0 1;_

wrap =: [: < [: ; planets&i.
step =: 1 ({"1) 4 $. {
orbit =: step&solar_system &.> ^:a: (wrap 'COM')
pathT =: [: |. step&(|:solar_system) &.> ^:a: @: wrap

path_you =: |. ,; pathT 'YOU'
path_san =: |. ,; pathT 'SAN'
m =: (#path_you) <. #path_san
lca =: (m {. path_you) = (m {. path_san)

lca_path =: 0 i.~ [: =/ [: ,. [: > [: pathT&> ;

ts =: 13 : '(# pathT x) + (# pathT y) - 2 * >: x (0 i.~ [: =/ [: ,. [: > [: pathT&> ;) y'

count_orbits =: [: +/ #&> * [: i. #
orbital_transfers =: ([: # [: pathT [) + ([: # [: pathT ]) - 2 * [: >: lca_path

partA =: count_orbits orbit
partB =: 'YOU' orbital_transfers 'SAN'

partA;partB



