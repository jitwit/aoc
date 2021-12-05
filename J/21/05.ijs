load '~/code/aoc/aoc.ijs'
in =: aoc 2021 5
pts =: _4 (_2]\])\ ". ' '(I. -. in e. a09)}in
ln =: {{ < ({.y) +"_ 1 (*dz) *"_ 0 i. >: >./ | dz =. -~/ y }}
+/ 1 < #/.~ ; ln"_1 (#~ +./@(=/)"_1) pts
+/ 1 < #/.~ ; ln"_1 pts
