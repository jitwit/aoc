load '~/code/aoc/aoc.ijs'
in =: aoc 2022 7

dirp =: 'dir' -: 3 {. >
lsp =: -: & (<'$ ls')
fs =: (#~ (1 - lsp +. dirp)"0) <;._2 in NB. file system without ls/dir
cdp =: ('$ cd'-:4&{.)&> <;.1 ] NB. group by cds
cdd =: (<'$ cd ..')={.&> fsg =: cdp fs NB. find where going down directory
d =: <: (-.cdd) # +/\ 1 - +: cdd NB. create depth vector
p =: P d
fsg =: (-.cdd) # fsg NB. directory tree with depth vector to specify structure
NB. (<"0 d) ,. fsg
sz =: [: ". [: {. [: ];._2 (,&' ')
szs =: , +/ |: (sz &> @: }.) &> fsg
NB. idea: take path expansions, and all children n are all nodes such
NB. that n appears in path to root. overall tree isn't that bad so
NB. this is fine
cszs =: ([: +/ szs {~ I.)"1 (i.#p) e."0 1/ |: (p&{)^:a: (i.#p)
+/ (#~ <:&100000) cszs
({~ [: {. [: I. (30000000-70000000-{.cszs)&<) /:~ cszs
