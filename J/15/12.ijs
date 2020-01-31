load '~/code/advent/code/biblio.ijs convert/json'

input=: dec_json freads < advent_input 15 12

val=: ]`0:@.(2=3!:0)
red=: (<'red')e.1&{
tally=: val`([:+/[:>$:&.>)`(([:$:1&{)`0:@.red)@.(#@$)

solve=: tally ;~ [: +/ tally S: 0

solve input
