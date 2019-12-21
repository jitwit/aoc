input=:'hepxcrrq'

letter=:i.~&'abcdefghijklmnopqrstuvwxyz '
bump=: >:&.(27&#.)

rule1=: [:0 1 2&e.[:(-<./"1)3]\] NB. increasing sequence of 3 somewhere in password
rule2=: [:-.[:+./(letter' iol')&e. NB. no iol in password
rule3=: 1<[:#[:~.]{~[:I.[:(=/"1)2]\] NB. two distinct repeating letters
good=: rule1 *. rule2 *. rule3

next_password=: 3 : 0
y=. letter y
while. -. good y do. y=. bump y end.
([ clipwrite) letter ^:_1 y
)

NB. rather slow, so commented out
NB. ]passwordA=: next_password input
NB. ]passwordB=: next_password (bump&.letter) passwordA
