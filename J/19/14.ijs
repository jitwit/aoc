load'~/code/aoc/aoc.ijs regex'

line =: ([: ". & > '[[:digit:]]+'&rxall) ,&< ('[[:upper:]]+'&rxall)
input=: line ;._2 aoc 2019 14
chems =: ~. ; {:"1 input
chem =: chems&i.
rules =: (1;chem<'ORE') , ({."1 input) ,. chem &.> {:"1 input
perm =: /: edges =: ,/ > ,. ({: ; }:) &.> {:"1 rules
edges =: {:"1 perm { edges
rules =: perm { rules

tsort =: 3 : 0
S=. V=. 0 $ n=. # indeg=. # &> y
while. n > #V do.
  V =. V , v =. {. V -.~ vs =. I. 0 = indeg
  indeg =. # &> y =. (-.&V) &.> y
end. V
)

fuel =: 3 : 0
fl =. y * (chem<'FUEL') = i.#edges
for_v. |. tsort edges do.
  'gs cs' =. v { rules
  t =. >. (v{fl) % {: gs
  fl =. ((fl {~ }:cs) + t * }:gs) (}: cs)} fl
end. (chem < 'ORE') { fl
)

bin =: 1 : 0
'lo hi s' =. y
while. lo < hi do. mid =. <. -: 1 + lo + hi
  if. s <: u mid do. hi =. mid - 1
  else. lo =. mid + 1 end.
end. hi
)

partA=: fuel 1
partB=: fuel bin 1 10000000 1000000000000
partA;partB
