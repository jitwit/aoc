msg=: 'ffykfhsq'
hash=: 15 (128!:6) msg,":

iter=: (>: ^: ([: -. '00000' -: 5 {. hash)) ^: _

buildA=: 3 : 0
'i ix password'=. 0;0;y#'?'
while. i < y
do. ix =. iter 1+ix [ echo < password
    password=. (5 { hash ix) i} password
    i=. >: i
end. password
)

buildB=: 3 : 0
'i ix password'=. 0;0;y#'?'
while. i < y
do. ix =. iter 1+ix
    echo password;'p c'=. 5 6 { hash ix
    if. p e. '01234567' do. p =. ". p
      if. '?' -: p{password do. i=.>:i [ password=. c p}password end.
    end.
end. password
)