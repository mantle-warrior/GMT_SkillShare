gmtset FONT_TITLE 20,30 FONT_ANNOT_PRIMARY 12
gmtset COLOR_BACKGROUND white
gmtset MAP_FRAME_TYPE FANCY
gmtset PLOT_DEGREE_FORMAT ddd:mm:ssF

set psf=west_pacific20180110.ps
set inf=\earth_relief_03m.grd
set gradf=G:\data\topo\global\gmt-relief\grad_relief_03m.nc
set incpt=sealand
rem set incpt=globe
set cptf=west_pacific.cpt  
set cptf2=west_pacific20180102.cpt  
set R=-R115/175/5/40
set J=-JM20c
REM set J=-Jl145/10/20/30/1:25000000 
        
del %psf%

rem makecpt -C%incpt% -T-10000/4000/200 -D -V -F -Z > %cptf%
rem makecpt -C%incpt% -T-22000/24000/2000 -D -V -F -Z > %cptf%

psbasemap %R% %J% -Bxa10f10 -Bya10f10 -BWseN -K -V >%psf%

grdimage %inf% -I%gradf% %R% %J% -C%cptf% -Q -O -K -V >> %psf%

rem pscoast -J -R -W1.5p,lightblue -A50000 -O -K >> %psf%
rem pscoast %R% %J%  -Ggray -A100 -O -K -V>> %psf%
rem psxy eez_boundaries.dat %R% %J% -W1p,gray -O -K -V >> %psf%

psscale -C%cptf% -Ba2000/:"  Depth (m)": -D4/-0.5/8/.4eh --MAP_FRAME_PEN=0.5p --TICK_LENGTH=0.15 --MAP_ANNOT_OFFSET_PRIMARY=0.1 --FONT_ANNOT_PRIMARY=12  -I -E -O -K -V >> %psf%

gmt psxy %R% %J% -T -O >> %psf%
psconvert %psf% -Tj -A+r -C-sFONTPATH=c:\windows\fonts -P
rem psconvert %psf% -Tf -A+r -C-sFONTPATH=c:\windows\fonts -P
