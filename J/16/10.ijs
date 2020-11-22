load'~/code/aoc/aoc.ijs'

3 : 0 ''
in =: ];._2 aoc 2016 10

instrs =: }."1 /:~ ". > 1 6 11 {"1 ;: (#~ {{ -. {. 'value' E. y }}"1) in
seeds =: ". > 1 5 {"1 ;: (#~ {{ {. 'value' E. y }}"1) in

bots =: a:"0 i. #instrs
seeds =: ((({.@:({:"1));{."1)/.~{:"1) seeds
bots =: ({:"1 seeds) (; {."1 seeds)} bots
push =: {{ bots =: (<y,x {:: bots) x} bots }} NB. add y to x's chips
pop =: {{ bots =: a: y} bots }} NB. add y to x's chips

for_i. i.#bots do.
 cs =. bots {::~ b =. {. I. 2 = #&>bots NB. not really necessary to check each time
 if. 17 61 -: /:~ cs do. partA =. b end.
 'i j' =. b { instrs
 i push <./ cs
 j push >./ cs
 pop b
end. partA , */ > 3 {. bots
)
