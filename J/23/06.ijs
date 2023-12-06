load '~/code/aoc/aoc.ijs'
in =: (}.~ 1+i.&':');._2 aoc 2023 6
NB. if pause p seconds, go p m/s.
NB. for how many p d>(t-p)*p
NB. d > tp - p^2
NB. p^2 - tp + d > 0
NB. t +/- sqrt(t-4d) / 2
q =: {{ 1+(>.a+1e_6)-~(<.b-1e_6)['a b'=.-:x(-,+)%:(x*x)-4*y }}
*/ q"0/ ".in
q/ (".@-.&' ')"1 in
