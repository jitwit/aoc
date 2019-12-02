
input =: 1 1 1 3 2 2 2 1 1 3 1
start =: 1

NB. close-ish to something helpful.
eq_inds =: }:@(=1&|.)
NB. on 0, there are # of occs of current thing equal to 1+ sum of
NB. proceeding block of 1s, if any.

NB. goal: 1 1 0 1 0 0 => 0 0 3 0 2 1
NB. basically, 0 resets, on reset tally running 1s.
NB. ([: ; {.&1&.>) 1 2 3 2 1
accum =: 4 : 0
if. x = 0
do. y
else. x
end.
)

