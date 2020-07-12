load 'web/gethttp stats/bonsai'
coclass 'aoc'


AOCDIR=: '/.aoc' ,~ 2!:5'HOME'
USER=: 'jitwit'

cookie_file=: 3 : 0
AOCDIR,'/cookies/',USER
)

save_cookie=: 1!:2 <@cookie_file
read_cookie=: 1!:1 @ <@cookie_file

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
file=. input_file y
try. assert. fexist file
     1!:1 < file
catch. 'hdr url'=. input_req y
       input=. url gethttp hdr
       input 1!:2 < file
       input
end.
)

3 : 0 '' NB. initialize
assert. fpathcreate AOCDIR,'/cookies/'
assert. fpathcreate AOCDIR,'/input/2015/'
assert. fpathcreate AOCDIR,'/input/2016/'
assert. fpathcreate AOCDIR,'/input/2017/'
assert. fpathcreate AOCDIR,'/input/2018/'
assert. fpathcreate AOCDIR,'/input/2019/'
)

aoc_z_ =: get_input_aoc_
update_cookie_z_ =: 3 : 0
1!:55 < cookie_file_aoc_ ''
y 1!:2 < cookie_file_aoc_ ''
)

