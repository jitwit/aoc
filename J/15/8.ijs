load '~/code/aoc/aoc.ijs'
input =: < ;. _2 aoc 2015 8

S=: (1 I.~ ('"';'\';'x';'0123456789abcdef') e.&>~ ])"0 a.
T =: 5 5 2 $ , ". ;. _2 ] 0 : 0
1 1  0 6  0 6  0 6  0 6 NB. parse string or stop
0 2  2 0  1 2  1 2  1 2 NB. 3 to say we read letter, 2 to start hex, 0 6 for end
1 2  1 2  3 0  0 6  0 6 NB. emit/do hex/bad
0 6  0 6  0 6  4 0  0 6 NB. read 1 hex/bad
0 6  0 6  0 6  1 2  0 6 NB. finish hex/bad
)

+/ (# + 2 - [: # (0;T;S)&;:) &> input
+/ 2 + (+/@,@('"\'&(=/))) &> input
