load '~/code/advent/code/biblio.ijs viewmat'

digits=: }: 0 "."0 advent_input 19 16
unbase10=: 10&#:^:_1

base_pat=: 13 : '}. (>:x) $ , y&$"0 ] 0 1 0 _1'
base_mat=: base_pat"0 (>: @ i.)
flawed_ftA=: 8 {. (10 | [: | ] (+/ . *)~ base_mat @ #) ^: 100

drop_offset=: (]}.~#|10#.7{.]),]$~#*[:<.#%~(10000*#)-10#.7{.]
flawed_ftB=: 7 {. [: (10 | +/\.) ^: 100 drop_offset

unbase10 &.> (flawed_ftA ; flawed_ftB) digits

output_pat =: 3 : 0
if. IFQT
do. pal=. |: 256 | (3 3 $ 0 85 170) + ? 3 # 256
    pal viewmat base_mat y
    savemat_jviewmat_'~/code/advent/J/19/Day16.png'
end.
)
output_pat 128