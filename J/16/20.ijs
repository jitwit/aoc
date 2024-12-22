load'~/code/aoc/aoc.ijs'
NB. swallow as many intervals as possble based on endpoint of first.
step=: {{ j=.(0{"1 y)I.(<0 1){y
          (j}.y),~((<0 0){y),>./,j{.y }}
merge=: ({.,$:@}.)@:(step^:_)`]@.(0=#)
ips=: merge /:~>([:".(;._1)'-',]);._2 aoc 2016 20

>:{:{. ips
(2^32x) + +/<:-/"1 ips
