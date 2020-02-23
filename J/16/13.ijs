NB. x*x + 3*x + 2*x*y + y + y*y
NB. (x+y)^2 + 3x + y
fun=: (3: * ]) + [ + [: *: +
gen=: adverb : '2 | +/ #: m + x fun y'
open=: 10 gen

grid=: [: (open"0 0)/~ i.

adj=: (4 2 $ 1 0 _1 0 0 1 0 _1) +"1 _ ]
NB. need connection graph.


NB. single source shortest paths...
NB. d (u,v) = 1 + min_(w -> v) d(u,w)

bfs=: verb define
dist =. 0 [seen=. ,: 1 1 [ q =. ,: 0 1 1 NB. point 1 1 at depth 0
while. -. ''-:q
do. 'd i j' =. {. q
    q =. }. q
    z0 =. i,j
    if. z0 -: y do. dist =. d break. end.
    d =. >: d
    for_z. adj z0
    do. 'i j' =. z
        if. (-. i open j) *. (0 <: j <. i) *. (-. z e. seen)
        do. seen=. z,seen
            q =. q,d,z
        end.
    end.
end. dist
)

bfs2=: verb define
dist =. 0 [seen=. ,: 1 1 [ q =. ,: 0 1 1
while. 0<#q do.
  'd i j' =. {. q
  q =. }. q
  d =. >: d
  for_z. adj (i,j)
  do. 'i j' =. z
      if. (0 <: j <. i) *. (d <: y) *. (-. i open j) *. (-. z e. seen)
      do. seen=. z,seen
          q =. q,d,z
      end.
  end.
end. #seen
)

NB. ]partA=: bfs 39 31
NB. ]partB=: bfs2 50
SIZE=: 10

connected=: dyad define
'x1 y1'=. SIZE ((<.@%~),|) x
'x2 y2'=. SIZE ((<.@%~),|) y
(x=y) +. (1=(|y2-y1)+(|x1-x2)) *. (x1 open y1) *. (x2 open y2)
)

G=: (=/~ i.SIZE*SIZE) -~ 1 + _ * -. connected"0/~ i.(SIZE*SIZE)
