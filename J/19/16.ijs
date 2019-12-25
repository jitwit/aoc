load '~/code/advent/code/biblio.ijs'

digits=: }: 0 "."0 advent_input 19 16
unbase10=: 10&#:^:_1

NB. part A
base_pat=: 13 : '}. (>:x) $ , y&$"0 ] 0 1 0 _1'
base_mat=: base_pat"0 (>: @ i.)
flawed_ftA=: 8 {. (10 | [: | ] (+/ . *)~ base_mat @ #) ^: 100

NB. part B
drop_offset=: (]}.~#|10#.7{.]),]$~#*[:<.#%~(10000*#)-10#.7{.]
flawed_ftB=: 7 {. [: (10 | +/\.) ^: 100 drop_offset

NB. out
unbase10 &.> (flawed_ftA ; flawed_ftB) digits

NB. Visual
output_pat =: 3 : 0
load 'viewmat'
pal=.3 3 $ 0 0 100 0 100 100 200 150 150
pal viewmat base_mat 128
savemat_jviewmat_'~/code/advent/output/Day16.png'
)