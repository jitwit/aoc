input=: 'b'freads<'~/code/advent/input/16/20.in'
intervals=: /:~>([:".(;._1)'-',])&.>input

NB. swallow as many intervals as possble based on endpoint of first.
step=: verb define
j =. (0{"1 y)I.(<0 1){y
(j}.y),~((<0 0){y),>./,j{.y
)

merge=: ({.,$:@}.)@:(step^:_)`]@.(0=#)

ips=: merge intervals

]partA=: >:{:{. ips
]partB=: (2^32x) + +/<:-/"1 ips