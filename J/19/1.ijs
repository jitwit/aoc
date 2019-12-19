require '~addons/ide/qt'

masses=: ". 'm' freads '~/code/advent/input/19/1.in'

fuel=: -&2@<.@%&3
fuelB=: 0:`(+$:@fuel)@.(0&<)

partA=: 3 : 0
answer=.+/fuel y
clipwrite_jqtide_ answer
answer
)

<"0 +/ (,. fuelB"0) fuel masses
