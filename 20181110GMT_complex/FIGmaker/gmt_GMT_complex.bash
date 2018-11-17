#!/bin/bash
fig_name=GMT_compleFig
fig_fmt=png

gmt set FONT_ANNOT_PRIMARY=12
gmt set FONT_ANNOT_PRIMARY=times-roman
gmt set MAP_FRAME_TYPE=fancy
gmt set COLOR_BACKGROUND=white
gmt set FORMAT_GEO_MAP ddd:mm:ssF

inf=earth_relief/earth_relief_05m.grd
gradf=earth_relief/grad_relief_05m-0.3.nc
gmt grdgradient $inf -A45 -Nt0.3 -fg -G$gradf -V

R=8/75/-57/-21
J=M20c
  
incpt=wysiwyg
cptf=GMT_complexFig.cpt
gmt makecpt -C$incpt -T-7000/0/1400 -D -V -F -Z > $cptf

gmt begin $fig_name $fig_fmt
gmt grdimage $inf -I$gradf -R$R -J$J -C$cptf -V -Q -Bx10f5 -Bya10f5 -BWseN
gmt coast -Sgray -A0 -t70 -V
gmt psscale -C$cptf -Ba2000f1000/:"  Depth (m)": -D4/-0.5/8/0.4h --MAP_FRAME_PEN=0.5p --MAP_TICK_LENGTH=0.15 --MAP_ANNOT_OFFSET_PRIMARY=0.1  -I -V
gmt basemap -Lfx15/-0.5/-38/500+u  -V
gmt coast -Ggray -A1000 

gmt psxy ridge/SWIR.txt  -Wthicker+s
gmt psxy ridge/SEIR.txt  -Wthicker+s
gmt psxy ridge/CIR.txt   -Wthicker+s
 
gmt psxy SWIR_TF/10E_Shaka.txt -Wthicker,darkgray+s  
gmt psxy SWIR_TF/25E_Du_Toit.txt -Wthicker,darkgray+s  
gmt psxy SWIR_TF/32.4E_Andrew_Bain.txt -Wthicker,darkgray+s  
gmt psxy SWIR_TF/33.9E_Marion.txt -Wthicker,darkgray+s  
gmt psxy SWIR_TF/35.2E_Prince_Edward.txt -Wthicker,darkgray+s  
gmt psxy SWIR_TF/39.3E_Eric_Simpson.txt -Wthicker,darkgray+s  
gmt psxy SWIR_TF/40.7E_Discovery2.txt -Wthicker,darkgray+s  
gmt psxy SWIR_TF/46.1E_Indomed.txt -Wthicker,darkgray+s  
gmt psxy SWIR_TF/52.3EGallieni.txt -Wthicker,darkgray+s  
gmt psxy SWIR_TF/57E_Atlantis2.txt -Wthicker,darkgray+s  
gmt psxy SWIR_TF/60.7E_Melville.txt -Wthicker,darkgray+s  
gmt psxy SWIR_TF/RTJ-north-trace.txt -Wthicker,darkgray,4_4_4_4:3p+s  
gmt psxy SWIR_TF/RTJ-south-trace.txt -Wthicker,darkgray,4_4_4_4:3p+s 

gmt psxy hydrothermal/hydrothermal_anomaly.txt -Sc10p -W0.2p,white -Gblue
gmt psxy hydrothermal/hydrothermal_vent.txt  -Sc10p -W0.2p,white -Gred
echo 43 -40.5 > area
echo 43 -41.5 >> area
echo 45 -41.5 >> area
echo 45 -40.5 >> area
gmt psxy area -Gred  -L -A
rm area

echo 55.5 -51 > legend
echo 55.5 -57 >> legend
echo 75 -57 >> legend
echo 75 -51 >> legend
gmt psxy legend -W1p,black -Gwhite  -L -A

echo 56.5 -52 > ridge.legend
echo 59.5 -52 >> ridge.legend
gmt psxy ridge.legend -Wthicker
echo 59.5 -52 ridge | gmt pstext -F+f12+jLM  -D0.3c/0c

echo 56.5 -53 > TF.legend 
echo 59.5 -53 >> TF.legend
gmt psxy TF.legend -Wthicker,darkgray
echo 59.5 -53 transfrom fracture | gmt pstext -F+f12+jLM  -D0.3c/0c

echo 56.5 -54 > RTJtrace.legend     
echo 59.5 -54 >> RTJtrace.legend
gmt psxy RTJtrace.legend -Wthicker,darkgray,4_4_4_4:3p+s 
echo 59.5 -54 RTJ trace | gmt pstext -F+f12+jLM  -D0.3c/0c

echo 58 -55 | gmt psxy -Sc10p -W0.2p,white -Gblue
echo 59.5 -55 hydrothermal anomaly | gmt pstext -F+f12+jLM  -D0.3c/0c
echo 58 -56 | gmt psxy -Sc10p -W0.2p,white -Gred
echo 59.5 -56 hydrothermal vent | gmt pstext -F+f12+jLM  -D0.3c/0c
rm legend ridge.legen TF.legend RTJtrace.legend

gmt coast -R-60/300/-90/90 -JG55/-40/6c -A20000 -W0.1p -Gblack -Swhite -Ba30g -V -Y8.25c
gmt psxy  ridge/SWIR.txt -W0.5p+s -V
gmt psxy  ridge/SEIR.txt -W0.5p+s -V
gmt psxy  ridge/CIR.txt -W0.5p+s -V
gmt psxy  ridge/AAR.txt -W0.5p+s -V
gmt psxy  ridge/slow.txt -W0.5p+s -V
echo 42 -41| gmt psxy -Sa15p -W0.1p,red -Gred -V

gmt end
open ${fig_name}.${fig_fmt}