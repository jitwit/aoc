require 'web/gethttp format/printf'

cookie=:'~/code/advent/.cookie'

advent_input=: 3 : 0
'~/code/advent/input/%d/%d.in'sprintf y
)

advent_req=: 3 : 0
out=.advent_input y
cki=._1}.'Cookie: session=',freads<cookie NB. newline(?), thence _1}.
hdr=.'-H "',cki,'" -o ',out
url=.'https://adventofcode.com/20%d/day/%d/input'sprintf y
hdr gethttp url
)

advent_reads=: 3 : 0
in=.advent_input y
if. -. fexist in do. advent_req y end.
freads < in
)

NB. #0f0f23
NB. #cccccc
NB. #99ff99
NB. #009900
NB. #10101a
NB. #ffff66
NB. #1e1e46