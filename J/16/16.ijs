load '~/code/aoc/aoc.ijs'
in=: '1' = }: aoc 2016 16

dragon=: {{(0,:x) ];.0 y,0,|.-.y}}^:_
checksum=: {{_2 =/\^:(0=2|#y)y}}^:_

,":"0 checksum 272 dragon in
,":"0 checksum 35651584 dragon in
