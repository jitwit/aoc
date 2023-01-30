load '~/code/aoc/aoc.ijs'
in =: aoc 2022 5
ixs =: <"1 ,/ (i.8) ,."_ 0/ 1+4*i.9
crates =: (<@:-.&' ')"1 ] _8 ]\ ixs { ] 8 {. ];._2 in

A =: 3 : 0
for_r. ". ;:^:_1 ] 1 3 5 {"1 ;: 10 }. ];._2 in do.
  'n a b' =. r
  'ca cb' =. (<:a,b) { crates
  xs =. n {. ca
  ca =. n }. ca
  cb =. (|.xs),cb
  crates =. (ca;cb) (<:a,b)}crates
end.
{.&>crates
)

B =: 3 : 0
for_r. ". ;:^:_1 ] 1 3 5 {"1 ;: 10 }. ];._2 in do.
  'n a b' =. r
  'ca cb' =. (<:a,b) { crates
  xs =. n {. ca
  ca =. n }. ca
  cb =. xs,cb
  crates =. (ca;cb) (<:a,b)}crates
end.
{.&>crates
)

A''
B''
