input=: LF-.~advent_reads 16 9

eg=: 'X(8x2)(3x3)ABCY'

marker=: i.&'()'
parse=: [: ". ;. _1 'x',]

split=: verb define
'ja jb' =. marker y
if. ja = jb do. ja;jb;'';'';y
else. 'a b' =. parse (>:ja) }. jb {. y
      head=. ja {. y
      tail =. (>:jb)}.y
      rep =. , b # ,: a {. tail
      a;b;head;rep;(a }. tail)
end.
)

decompress2=: verb define
'ja jb' =. marker y
if. ja = jb do. #y
else. 'a b' =. parse (>:ja) }. jb {. y
      head=. ja {. y
      tail =. (>:jb)}.y
      rep =. , b # ,: a {. tail
      NB. works because if it didn't, nothing could! (would diverge)
      NB. probably not true? could expand then finally contract
      (#head)+(b*decompress2 a{.tail)+(decompress2 a}.tail)
end.
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