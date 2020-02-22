input=: 'b' freads < '~/code/advent/input/16/8.in'

screen =: 6 50 $ 0

rt=: 4 : '1 (({. y) (([: <"1 ,"0/) & i.) ({: y))} x'
rr=: 4 : '((-({:y)) |. ({.y) { x) ({.y)} x'
rc=: 4 : 'rr&y &.|: x'

parse=: verb define
toks =. ;: y
if. 'rect' -: 0 {:: toks do. ;: ^:_1 'rt';|.<;._1 'x',1{::toks
elseif. 'row' -: 1 {:: toks do. ;: ^:_1 'rr';(_3 {:: toks);(_1 {:: toks)
else. ;: ^:_1 'rc';(_3 {:: toks);(_1 {:: toks)
end.
)

eval=: verb define
for_a. input do. ". 'screen =: screen ',parse > a end.
)

eval''
]partA=: +/^:2 screen
NB. viewmat in jqt for part B