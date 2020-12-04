load '~/code/aoc/aoc.ijs'
pp =: ({{<;._1':',y}};._1)@:{{' ' (I.LF=y)}y}}
ppids =: ;: 'eyr ecl pid byr hgt iyr hcl'
validA =: [: *./ ppids e. ,@:({."1)
P =: (<@pp;._2~ (2#LF)&E.) LF,(aoc 2020 4),LF

+/ # (#~ validA &>) P

