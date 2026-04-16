pload MODELING VISUALIZATION

# text presentation parameters
if {[info exists tparams]} { unset tparams }
array set tparams {
-font     "sans"
-height   30
-aspect   "REGULAR"
-wrapping 0
-halign   "LEFT"
-valign   "BOTTOM"
-angle    0
-dispType "NORMAL"
-color    "BLACK"
-subcolor "GRAY"
-flipping 0
}
# text itself
set ttext "My text\nlabel"
# text anchor point in 3D
set tpos {100 0 300}

# display a box in the background
vinit View1
vbackground -color WHITE
box b 100 200 300
vdisplay -dispMode 1 b -noselect
vpoint p1 {*}$tpos
vpoint p0 0 0 0
vpoint p2 200 0 0
vsegment s p0 p2
vremove p2
vaspects s -color BLACK
vdisplay s -trsfPers zoomRotate -trsfPersPos {*}$tpos
vfit

# display text label
puts "vdrawtext t \"$ttext\" -pos $tpos [array get tparams]"
vdrawtext t "$ttext" -pos {*}$tpos {*}[array get tparams]
