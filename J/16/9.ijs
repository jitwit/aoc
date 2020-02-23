input=: LF-.~advent_reads 16 9

eg=: 'X(8x2)(3x3)ABCY'

marker=: i.&'()'
parse=: [: ". ;. _1 'x',]

split=: verb define
'ja jb' =. marker y
if. ja = jb do. ja;jb;'';'';y
)

decompress=: verb define
s =. y
n =. 0
while. do.
  'ja jb a b c' =. split s
  if. s -: c do. break. end.
  n =. n+(#a)+(#b)
  s =. c
end. n+#s
)

]partA=: decompress input
]partB=: decompress2 input