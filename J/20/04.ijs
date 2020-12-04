load '~/code/aoc/aoc.ijs'
pp =: ({{<;._1':',y}};._1)@:{{' ' (I.LF=y)}y}}
ppids =: ;: 'byr iyr eyr hgt hcl ecl pid'
validA =: [: *./ ppids e. ,@:({."1)
P =: (<@pp;._2~ (2#LF)&E.) LF,(aoc 2020 4),LF

+/ # (#~ validA &>) P

vbyr =: (4=#) *. 1 = 1919 2002 I. _&".
viyr =: (4=#) *. 1 = 2009 2020 I. _&".
veyr =: (4=#) *. 1 = 2019 2030 I. _&".
vcm =: 1 = 149 193 I. _ ". _2&}.
vin =: 1 = 58 76 I. _ ". _2&}.
vhgt =: vin`vcm@.('cm'-:_2&{.)
vhcl =: ('#'={.) *. 6 = +/ @: e.&('abcdef',,/ ":"0 i.10)
vecl =: e.&(_3 ]\ 'ambblubrngrygrnhzloth')
vpid =: 9 = +/ @: e.&(,/ ":"0 i.10)

V =: {{ u 1 {:: y }}
K =: ppids i. {.

checkB =: (vbyr V)`(viyr V)`(veyr V)`(vhgt V)`(vhcl V)`(vecl V)`(vpid V)`0:@.K
validB =: 7 = +/ @: (checkB"1)

+/ validB &> P
