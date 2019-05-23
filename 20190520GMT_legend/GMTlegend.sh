#!/bin/bash
fig_name=GMTlegend

fig_fmt=jpg # pdf for vector diagram

gmt set FONT_ANNOT_PRIMARY=12
gmt set FONT_ANNOT_PRIMARY=Times-Roman
gmt set COLOR_BACKGROUND=white

gmt begin $fig_name $fig_fmt

gmt pslegend -D2c/1c+w7c+jBR+l1.5c -C0.2c/0.2c -F+p+i+ggray80 --FONT_LABEL=12p  << EOF
H 15p Times-Roman MY LEGEND  
#title
D 0.2c 1p 
# boundary between title and legend 
# symbol space legend type length (-) thickness,color space name
S 0.8c   -      0.8c        -    1p,black           1.5c  line
S 0.8c   -      0.8c        -    3p,gray60          1.5c  thick gray line
S 0.8c   -      0.8c        -    1p,2_2_2_2:2p      1.5c  dashed line
S 0.8c   p      0.1c        -    black              1.5c  point
S 0.8c   s      0.4c             black 0.1p         1.5c  square
S 0.8c   c      0.25c            red 0.6p,black     1.5c  red circle with black boundary
S 0.8c   a      0.4c             red 0.6,blue       1.5c  red circle with blue boundary
S 0.8c f+r+f 0.8c/0.2c/0.2c -    1.0p,red           1.5c  fault

L - - L MOR: Mid-Ocean Ridge
L - - L TF: Transform Fault
EOF

#-D[X]/[Y]+w[width]+jBR+l[line space]
#-C:space between legend and frame
#-F+p(frame1)+i(frame2)+g[background color]

gmt end
rm gmt.*
open  $fig_name.$fig_fmt
