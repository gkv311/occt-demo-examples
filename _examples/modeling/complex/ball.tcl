pload MODELING VISUALIZATION

vinit View1
vsetdispmode 1
vaspects -faceBoundaryDraw 1
vtrihedron t

set step 0
proc animpause {} { wait 0; incr ::step; }

puts "Constructing ball body..."
psphere se 100
vdisplay -noupdate se
vfit
#vzoom 0.9
animpause

puts "Cutting cylindrical hole from sphere..."
plane cp cos(pi/4)*50 sin(pi/4)*50 sin(pi/4)*50 1 1 1
pcylinder c cp 50 50
vaspects se -transparency 0.5
vdisplay -noupdate c
vaspects c -color RED
animpause
bcut b se c
vremove -noupdate se c
vdisplay b
animpause

puts "Adding fillets to the hole..."
explode b W
explode b_2 E
vdisplay -noupdate b_2_1 -topmost
vaspects b_2_1 -color BLUE
animpause
fillet b b 2 b_2_1
vremove -noupdate b_2_1
vdisplay b
animpause

puts "Fusing with a sphere inside..."
psphere si 80
vaspects b -transparency 0.5
vdisplay -noupdatesi
vaspects si -color GREEN
animpause
bfuse b bsi
vremove -noupdatesi
vdisplay -noupdate b
vaspects b -transparency 0
animpause

puts "Constructing stand..."
plane cp2 0 0 -110 0 0 1 0 1 0
pcylinder c2 cp2 75 40
vaspects -noupdate b -transparency 0.9
vdisplay c2
animpause

puts "Adding fillets to the stand..."
explode c2 E
vdisplay -noupdate c2_1 c2_3 -topmost
vaspects c2_1 c2_3 -color BLUE
fillet c2 c2 5 c2_1 5 c2_3
vremove -noupdate c2_1 c2_3
vdisplay c2
animpause

puts "Cutting hole in the stand..."
pcylinder c2i cp2 60 50
vaspects -noupdate c2 -transparency 0.5
vdisplay -noupdate c2i
vaspects c2i -color RED
animpause
bcut s c2 c2i
vremove -noupdate c2 c2i
vdisplay s
animpause

puts "Cutting main sphere from the stand..."
vaspects b -color RED -transparency 0
animpause
bcut s s b
vaspects -noupdate b -unsetcolor -transparency 0.9
vdisplay s
animpause

puts "Cutting box from the stand..."
box bb cos(pi/4)*20 sin(pi/4)*20 -110 60 60 60; vdisplay bb
vdisplay -noupdate bb
vaspects -noupdate s -transparency 0.5
vaspects bb -color RED
animpause
bcut s s bb
vremove -noupdate bb
vdisplay s
animpause

puts "Showing result..."
vremove -noupdate b s
vdisplay b s
animpause
