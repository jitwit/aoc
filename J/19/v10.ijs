require '10.ijs gl2 api/gles ~addons/ide/qt/opengl.ijs'
coinsert 'jgl2 jgles qtopengl'

STOP =: 0
go =: 0
as =: +. Z
zs =: 0 2 $ 0
beta =: 0
E =: 0 0 50
C =: -: >./ as
U =: 0 1 0
M =: glu_LookAt E,C,U
theta =: phi 0j1
dtheta =: 0.001
zcol =: 0 0 0
dzcol =: 3 10 2


v =: 0 : 0
pc aoc10 closeok; minwh 400 400;
cc g opengl flush;
cc b button;
)

aoc10_b_button =: 3 : 0
select. STOP =: -. STOP
case. 0 do. wd 'ptimer 50'
case. 1 do. wd 'ptimer 0' end. echo STOP
)

aoc10_timer =: 3 : 0
if. 1=STOP do. return. end.
gl_sel HD
gl_paint ''
)

aoc10_g_paint =: 3 : 0
echo 'paint ',": 6!:0 ''
echo theta =: theta + dtheta
gl_sel HD
wh=. gl_qwh''
gl_clear''
glClearColor 0.4 0.8 0.9 1
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
gl_rgb 255 255 255
gl_pen 10 1
echo $ zs =: ({.as),zs
echo $ as =: }. as
for_a. as do.
  gl_pixel <. 10 * a
end.
gl_rgb zcol =: 255 | zcol + dzcol
gl_pen 10 1
if. #zs do.
  gl_pixel <. 10 * {. zs
end.
gl_rgb 255 100 100
gl_pen 10 1
for_z. }. zs do.
  gl_pixel <. 10 * z
end.
if. 0 = # as
do. as =: +. Z
    zs =: 0 2 $ 0
end.
)

aoc10_close =: 3 : 0
wd 'psel aoc10; ptimer 0; pclose'
)

courir =: 3 : 0
aoc10_close^:(wdisparent'aoc10')''
wd v
HD=: ".wd'qhwndc g'
wd 'ptimer 3000; pshow'
)

courir ^: (go *. IFQT) ''
