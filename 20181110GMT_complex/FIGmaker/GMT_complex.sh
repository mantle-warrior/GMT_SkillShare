#!/bin/bash
fig_name=figure2
fig_fmt=pdf
gmt begin $fig_name $fig_fmt

gmt set FONT_ANNOT_PRIMARY=12
# gmt set FONT_ANNOT_PRIMARY=times-roman
gmt set MAP_FRAME_TYPE=plain
gmt set COLOR_BACKGROUND=white
gmt set FORMAT_GEO_MAP ddd:mm:ssF

# inf=/Volumes/jie/data_project/topo_global/GEBCO_2014_2D.nc
# gradf=/Volumes/jie/data_project/topo_global/grad_GEBCO_2014_2D-0.8.nc
inf2=/Users/jiechen/onedrive/data_project/topo_global/ship_bathymetry0.027m.nc
gradf2=/Users/jiechen/onedrive/data_project/topo_global/grad_ship_bathymetry0.027m_0.4.nc
# inf2=/Volumes/jie/data_project/topo_global/ship_bathymetryboite_ouest_49_5230.grd
# grad2=/Volumes/jie/data_project/topo_global/grad_ship_bathymetryboite_ouest_49_5230.nc

# gmt grdgradient $inf -A135/135 -Nt0.4 -fg -G$gradf -V
gmt grdgradient $inf2 -A135 -Nt0.4 -fg -G$gradf2 -V
# gmt grdgradient $inf3 -A45 -Nt0.5 -fg -G$gradf3 -V

incpt=haxby
cptf=longqi.cpt
# gmt makecpt -C$incpt -T-3700/-900/400 -D -V -F -Z > $cptf

R=49.4/50.05/-37.96/-37.55
# R=49.59/49.815/-37.845/-37.7
J=M20c
# gmt grdimage $inf -I$gradf -R$R -J$J -C$cptf  -Bxa20mf5m -Bya20mf5m -Q -V
gmt grdimage $inf2 -I$gradf2 -R$R -J$J -Clongqi-bathy.cpt -V -Q -Bx10mf5m -Bya5mf5m -BWseN
# gmt grdimage $inf3 -I$gradf3 -R$R -J$J -C$cptf -V -Q
#--MAP_ANNOT_OFFSET_PRIMARY=0.3 --MAP_TICK_LENGTH=0.2
gmt psscale -C$cptf -Ba500/:"  Depth (m)": -D4/-0.5/8/0.4h --MAP_FRAME_PEN=0.5p --MAP_TICK_LENGTH=0.15 --MAP_ANNOT_OFFSET_PRIMARY=0.1  -I -V
gmt basemap -Lfx15/-0.5/-38/5+u  -V

gmt psxy /Users/jiechen/onedrive/data_project/segment/28.txt  -W3p,white+s
gmt psxy /Users/jiechen/onedrive/data_project/segment/28O.txt  -W3p,white+s
gmt psxy GPS_vent.txt -Sa20p -W0.8p,white -Gred -V
# gmt psxy block_AL.txt  -W0.5p,yellow -L -V

# gmt psxy block_C.txt  -W0.5p -L
# gmt psxy block_A.txt  -W0.5p -L
gmt psxy block_AL.txt  -W0.5p,yellow -L

# gmt pstext rock_AL-2.txt -F+f12,Times-Roman -D0/0.3
gmt psxy rock_AL-2.txt  -Sc8p -Gblack -W0.3p,white

# gmt psxy /Volumes/jie/data_project/vent/contract_vent_anomaly20180426.txt -Sc0.5c -Gblack -V

# gmt psxy area.txt -W2p,red  -A -L -V
# gmt psconvert
# gmt clear conf
gmt end
open ${fig_name}.${fig_fmt}
