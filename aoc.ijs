load 'web/gethttp stats/bonsai'
coclass 'aoc'

AOCDIR=: jpath '~/code/aoc'

cookie_file=: 3 : 0
AOCDIR,'/cookie'
)

save_cookie=: 1!:2 <@cookie_file
read_cookie=: 1!:1@<@cookie_file

input_file=: 3 : 0
'y d'=. ": &.> y
AOCDIR,'/input/',y,'/',d,'.in'
)

input_url=: 3 : 0
'y d'=. ": &.> y
'https://adventofcode.com/',y,'/day/',d,'/input'
)

input_exists=: fexist @ input_file

input_req=: 3 : 0
out=. input_file y
cki=.'Cookie: session=',read_cookie y
hdr=.'-H "',cki,'"'
hdr ; input_url y
)

get_input =: 3 : 0
'y d' =. y
'cy cm cd' =. 3 {. 6!:0 ''
assert. *./ (1<:d),(d<:25),(2015<:y),(y<:2021)
assert. (y<2021)+.(cy=y)*.(d<:cd)*.(cm=12)
file=. input_file y,d
try. assert. fexist file
     1!:1 < file
catch. 'hdr url'=. input_req y,d
       input=. 2!:0 'curl ', (>hdr) , ' ' , >url
       if. +./'Puzzle inputs differ by user'E.input do. echo input
       else. input 1!:2 < file end.
       input
end.
)

3 : 0 '' NB. initialize
assert. fpathcreate AOCDIR,'/input/2015/'
assert. fpathcreate AOCDIR,'/input/2016/'
assert. fpathcreate AOCDIR,'/input/2017/'
assert. fpathcreate AOCDIR,'/input/2018/'
assert. fpathcreate AOCDIR,'/input/2019/'
assert. fpathcreate AOCDIR,'/input/2020/'
assert. fpathcreate AOCDIR,'/input/2021/'
)

aoc_z_ =: get_input_aoc_
update_cookie_z_ =: 3 : 0
1!:55 < cookie_file_aoc_ ''
y 1!:2 < cookie_file_aoc_ ''
)

bfs =: 4 : 0
 NB. get tree from bfs starting at x in graph y
 Q =. ~.,x NB. seed queue from x and mark x explored
 S =. -. (T =. i.#y) e. x NB. explored v iff 0 = v{S
 while. #Q do. 'u Q' =. ({.;}.) Q NB. pop Q
  vs =. I. S * u{y NB. unexplored out edges u -> v
  Q =. vs ,~ Q NB. push vs
  S =. 0 vs} S NB. mark vs explored
  T =. u vs} T NB. indicate parent in tree T
 end. T
)

egcd =: 4 : 0 NB. extended euclid
 'a b c d s t' =. 1 0 0 1,x,y
 while. r =. t - s*q =. <. t%s do.
   c =. t [ a =. c-q*a [ t =. a
   d =. t [ b =. d-q*b [ t =. b
   s =. r [ t =. s
 end. a,b,s assert. s = (a*x) + b*y
)

crt =: 4 : 0 NB. chinese remainder theorem
 's t g'=.m egcd n['b n'=.y['a m'=.x
 <.(<.m*n%g)(|,[)(a*t*<.n%g)+(b*m*<.s%g) assert. 0 = g | a-b
)

bfs_z_   =: bfs_aoc_
bez_z_   =: bez_aoc_
crt_z_   =: crt_aoc_
