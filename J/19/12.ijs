input=: ([:<;._1' ',-.&'<>xyz=,')&.>'b'freads<'~/code/aoc/input/19/12.in'
moons=: (3 4$0),.~|:>".&.>>input

step=: +(4|.!.0])"1+[:,.~([:([:+/[:*-/~)4&{.)"1
energy=: [:+/[:(_4&{.*4&{.)[:+/|

period=: dyad define
n=.1[z=.step]x=. ,:y{x
while. -.z-:x do. n=.n+1 [ z=.step z end. n
)

]partA=: energy step^:1000 moons
]partB=: *./ moons period"_ 0 i.3