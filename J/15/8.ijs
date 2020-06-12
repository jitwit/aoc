input =: < ;. _2 freads < '~/code/aoc/input/15/8.in'

NB. STATE TABLE:
NB. CHAR CLASS: quote, back, x (hex), hex chars, other chars
char=: 1 I.~ ('"';'\';'x';'0123456789abcdef') e.&>~ ]
NB. STATE: 0 start/end; 1 letter; 2 backslash; 3 hexbegin; 4 hex1; 5 hex2
table=: 5 5 2 $ , ". ;. _2 ] 0 : 0
1 1  0 6  0 6  0 6  0 6 NB. parse string or stop
0 2  2 0  1 2  1 2  1 2 NB. 3 to say we read letter, 2 to start hex, 0 6 for end
1 2  1 2  3 0  0 6  0 6 NB. emit/do hex/bad
0 6  0 6  0 6  4 0  0 6 NB. read 1 hex/bad
0 6  0 6  0 6  1 2  0 6 NB. finish hex/bad
)

NB. tokenize string with our mealy machine, take length, subtract 2
NB. for enclosing quotes.
string_data=: 2 -~ [: # (3;table;char"0 a.) ;: ]
needs_escape=: e.&'"\'

partA;timespacex'partA=: +/ (# - string_data) &> input'
partB;timespacex'partB=: +/ (2 + +/@:needs_escape) &> input'
