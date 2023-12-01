load '~/code/aoc/aoc.ijs regex'
in =: ];._2 aoc 2023 1

in0 =: ];._2 ] 0 : 0
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
)

f =: (". @ ({~ ({.,{:) @ I. @ (e.&'1234567890')))"1
+/ f in0
d =: 'zero one two three four five six seven eight nine'
rxp =: 'zero|one|two|three|four|five|six|seven|eight|nine'
t =: [: ": (;: d) i. <
+/ f rxp t rxapply"1 in
