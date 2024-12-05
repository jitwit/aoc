load '~/code/aoc/aoc.ijs'
in =: aoc 2024 5
eg =: 0 : 0
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
)

R =: ([:".[:> 0 2{;:);._2 (1+n =: I. (LF,LF) E. in) {. in   NB. rules
L =: {{<".' '(I. js)}y[ js=.','=y}};._2 (n+2) }. in         NB. pages
P =: {{*./<:/"1 js #~ -.(#y) e."1 js=.y i. x}}              NB. in order?
+/(([:<.2%~#){])&> L #~ C =: R&P &> L                       NB. part A
u =: {{ if. *./ x e. y do. (|.x) (y i. x)} y else. y end. }}
U =: {{ for_i. x do. y=. x i y end. }}

NB. for each rule r in which both appear, replace both with rule ordering where they appear...
(3 2,:100 1) u"1 ] 1 2 3 4

