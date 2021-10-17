load '~/code/aoc/aoc.ijs'
parse =: ({{<;._1':',y}};._1)@:{{' ' (I.LF=y)}y}}
keys =: ;: 'byr iyr eyr hgt hcl ecl pid'
S =: +/ @: &> NB. modifier train equiv to {{ +/ u & > y }}
P =: (<@parse;._2~ (2#LF)&E.) LF,(aoc 2020 4),LF

NB. part A
([: *./ keys e. ,@:({."1)) S P

byr =: 1 = 1919 2002 I. _&".
iyr =: 1 = 2009 2020 I. _&".
eyr =: 1 = 2019 2030 I. _&".
cm =: 1 = 149 193 I. _ ". _2&}.
in =: 1 = 58 76 I. _ ". _2&}.
hgt =: in`cm@.('cm'-:_2&{.)
hcl =: ('#'={.) *. 6 = +/ @: e.&'0123456789abcdef'
ecl =: e.&(_3]\'ambblubrngrygrnhzloth')
pid =: 9 = +/ @: e.&'0123456789'

V =: @ (1&{::) NB. modifier train equiv to {{ u 1 {:: y }}
vkey =: (byr V)`(iyr V)`(eyr V)`(hgt V)`(hcl V)`(ecl V)`(pid V)`0:@.(keys i. {.)

NB. part B
(7 = +/ @: (vkey"1)) S P
