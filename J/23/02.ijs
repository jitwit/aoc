load '~/code/aoc/aoc.ijs'
in =: <;._2 aoc 2023 2

p =: {{ (".>{.y) ((;:'red green blue')i.{:y)} 0 0 0 }} NB. parsing
parse =: {{([:(p@;:);._1 ','&,);._1';',{:];._1':',>y}}

+/1+I.([:*./[:,12 13 14 >:"1[:+/"_1 parse)"0 in NB. part a
+/(*/@(>./)@(>./"_1)@parse)"0 in                NB. part b
