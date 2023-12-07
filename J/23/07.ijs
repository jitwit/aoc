load '~/code/aoc/aoc.ijs'
in =: ];._2 aoc 2023 7

H =: '23456789TJQKA' i. 5{."1 in  NB. cards
V =: ". 6}."1 in                  NB. values
F =: \:~ @: (#/.~)"1              NB. hand quality metric
H =: /:~ H [ V =: (/: H) { V      NB. sort by rank
H =: (/:F) H [ V =: (/: F H) { V  NB. sort by hand quality
+/(*1+i.@#) V

NB. same as part A except for metric, which makes jacks wild 
H =: 'J23456789TQKA' i. 5{."1 in
V =: ". 6}."1 in
F =: {{ (z+{.y),}.y=.\:~#/.~\:~y-.0 [ z=.+/0=y }}"1
H =: /:~ H [ V =: (/: H) { V
H =: (/:F) H [ V =: (/:F H) { V
+/(*1+i.@#) V
