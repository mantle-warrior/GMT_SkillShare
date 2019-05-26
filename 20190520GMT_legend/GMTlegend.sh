#!/bin/bash
gmt set FONT_ANNOT_PRIMARY=12
gmt set FONT_ANNOT_PRIMARY=Times-Roman
gmt set COLOR_BACKGROUND=white
gmt set FONT_ANNOT_PRIMARY 12p  FONT_LABEL 12p

fig_name=MYlegend
fig_fmt=jpg 
gmt begin $fig_name $fig_fmt
gmt pslegend -D2c/1c+w7c+jBR+l1.5c -C0.2c/0.2c -F+p+i+ggray80   << EOF
H 15p Times-Roman MY LEGEND  
#this is the title
D 0.2c 1p 
# boundary between title and legend 
# symbol space legend type length (-) thickness,color space LegendName
S 0.8c   -      0.8c        -    1p,black           1.5c  line
S 0.8c   -      0.8c        -    3p,gray60          1.5c  thick gray line
S 0.8c   -      0.8c        -    1p,2_2_2_2:2p      1.5c  dashed line
S 0.8c   p      0.1c        -    black              1.5c  point
S 0.8c   s      0.4c             black 0.1p         1.5c  square
S 0.8c   c      0.25c            red 0.6p,black     1.5c  red circle with black boundary
S 0.8c   a      0.4c             red 0.6,blue       1.5c  red circle with blue boundary
S 0.8c f+r+f 0.8c/0.2c/0.2c -    1.0p,red           1.5c  fault
EOF

#-D[X]/[Y]+w[width]+jBR+l[line space]
#-C:space between legend and frame
#-F+p(frame1)+i(frame2)+g[background color]

gmt end
rm gmt.*
open  $fig_name.$fig_fmt
