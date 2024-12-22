load'~/code/aoc/aoc.ijs'
in =: ".;._2 aoc 2024 22
M1 =: 16777216 | (22 b. 64&*) NB. 22 b. is bitwise xor
M2 =: 16777216 | (22 b. [: <. %&32)
M3 =: 16777216 | (22 b. 2048&*)
F =: M3 @ M2 @ M1
M =: F^:(i.2001) in NB. full table of prices
+/ {: M
dM =: |: 2 -~/\ 10 | M NB. table of differences
S =: ~. ,/ ] 4 ]\"1 dM NB. unique sequences of 4
NB. compute banana sales for given sequence
B =: {{ ixs=. (,.i.@#) 4 + y ([:{._,~I.@E.)"1 dM
        +/ 10 | (<"1 ixs #~ _ ~: {."1 ixs){M }}
NB. since brute force is slow, print progress as we look at how many
NB. bananas from each sequence
partB =: 3 : 0
i =. 0[b =. 0
for_s. /:~ S do.
  i =. 1+i [ b =. b >. t =. B s
  echo (i%#S);b;t;s
end.
)
