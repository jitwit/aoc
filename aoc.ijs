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
assert. *./ (1<:d),(d<25),(2015<:y),(y<:2020)
assert. (y<2020)+.(cy=y)*.(d<:cd)*.(cm=12)
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
)

aoc_z_ =: get_input_aoc_
update_cookie_z_ =: 3 : 0
1!:55 < cookie_file_aoc_ ''
y 1!:2 < cookie_file_aoc_ ''
)
