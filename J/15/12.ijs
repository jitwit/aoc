load '~/code/advent/code/biblio.ijs convert/json'
input=: dec_json freads < advent_input 15 12

tally=: ]`0:@.(2=3!:0)`([:+/[:>$:&.>)`(([:$:1&{)`0:@.((<'red')e.1&{))@.(#@$)

]solution=:(tally;~[:+/tally S:0) input

