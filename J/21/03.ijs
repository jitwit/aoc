load '~/code/aoc/aoc.ijs'
in =: '1'&=;._2 aoc 2021 3

G =: -:@# <: +/ NB. gamma
(*&#. -.) G in  NB. part A

O =: (#~ ({~"1 [: {. [: I. #>+/)@:(="1 _ G)) ^: _
C =: #~ ({~"1 [: {. [: I. (0&<*.#&>)@+/)@:-.@(="1 _ G)
CO2 =: C`]@.(1=#) ^:_

(O *&#. CO2) in NB. part B
