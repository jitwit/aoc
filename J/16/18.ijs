load'~/code/aoc/aoc.ijs'

tiles =: '^' = }: aoc 2016 18
rules =: #. _3 '^'&=\ '^^..^^^....^'
step =: e.&rules @: #. @: |: @: ((i:1)&(|.!.0"0 _/))

+/,-.step^:(i.40) tiles
+/,-.step^:(i.400000) tiles
