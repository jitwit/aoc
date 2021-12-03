load '~/code/aoc/aoc.ijs'
in =: '1'&=;._2 aoc 2021 3
NB. ] 1!:1 < '3.txt'
NB. 
G =: -:@# <: +/     NB. gamma
P =: (*&#. -.) @ G  NB. power consumption
P in

NB. find most common bits. take first column where not all are equal.
NB. select those items which share most common bit.
O =: {{ y #~ ({~"1 [: {. [: I. #>+/) g =. (="1 _ G) y }}
C =: {{ y #~ ({~"1 [: {. [: I. (0&< *. #&>) @ +/) g =. -. (="1 _ G) y }}
(#. O^:12 in) * #. C^:9 in
