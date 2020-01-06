moons=: (|: 4 3 $ 3 2 _6 _13 18 10 _8 _1 13 5 10 4) ,. (3 4 $ 0)

step=: ] + (4|.!.0])"1 + [: (],.]) ([: ([:+/[:*[-/[) 4&{.)"1
energy=: [: +/ [: (_4&{.*4&{.) [: +/|

NB. bounding box of moon positions
box=: (<./,>./)@(4&{.)"1

period=: 4 : 0
n=.1 [ z=.step ] y=. 1 8 $ x{y
while. -. z -: y 
do. n=.n+1 [ z=.step z 
end. n
)

NB. (energy step ^: 1000 moons); *./ period&moons"0 i.3


