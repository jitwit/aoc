require 'web/gethttp format/printf'

cookie=:'~/code/advent/.cookie'

advent_path=: 3 : 0
'~/code/advent/input/%d/%d.in'sprintf y
)

advent_req=: 3 : 0
out=.advent_path y
cki=._1}.'Cookie: session=',freads<cookie NB. newline(?), thence _1}.
hdr=.'-H "',cki,'" -o ',out
url=.'https://adventofcode.com/20%d/day/%d/input'sprintf y
hdr gethttp url
)

advent_input=: 3 : 0
in=.advent_path y
if. -. fexist in do. advent_req y end.
freads < in
)

NB. advent_req 16 2
advent_input 16 3