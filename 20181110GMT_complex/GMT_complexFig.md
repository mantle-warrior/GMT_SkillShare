# GMT复杂图制作教程———让作图简单的飞起来
GMT是地学界常用的开源软件，不仅是因为其开源的特性，还有着独特的魅力。GMT可以对海岸线、地形、投点等进行综合表现，满足我们的学术论文。但是笔者发现，目前仍然缺乏某些特定的GMT画图教程，如本文所要分享的复杂海底地形图。本文适合初学者，也适合具有一定基础的海洋地质地球物理学科专业的同学。

## 图层
GMT的画图是通过图层的不断叠加来实现的，画图者需要做的就是先画出底图，然后在此基础上叠加需要的图层。本文就是以图层顺序的方式进行分享，这样可以对图层进行随意删减或者改变顺序。需要说明的是，本文所写的代码使用Mac下最新版本的软件GMT6

GMT6的[安装]åscholar.coding.me/2018/10/22/post_19/")、详细模块讲解请参照[GMT官网]("http://gmt.soest.hawaii.edu/doc/5.4.4/index.html")或者[GMT中文网]("https://gmt-china.org/")。

闲话少说，下面就开始了！

### 准备工作
```
#!/bin/bash
fig_name=GMT_complexFig
fig_fmt=png
gmt set FONT_ANNOT_PRIMARY=12
gmt set FONT_ANNOT_PRIMARY=times-roman
gmt set MAP_FRAME_TYPE=fancy
gmt set COLOR_BACKGROUND=white
gmt set FORMAT_GEO_MAP ddd:mm:ssF
```
定义图名和图片格式，自定义部分GMT默认值，分别是字体大小、字体格式、地图的外框、背景颜色和经纬度标注格式
```
inf=earth_relief/earth_relief_05m.grd # 地形网格文件
gradf=earth_relief/grad_relief_05m.nc # 地形梯度网格文件
gmt grdgradient $inf -A45 -Nt0.3 -fg -G$gradf 
```
梯度网格文件的生成，，目的是使底图具有阴影效果。在此强调一下-Nt选项，后面的数字越小，地形越平坦，在图范围较大情况下，建议0.5以下。
```
R=8/75/-57/-21 #图的经纬度范围
J=M20c #墨卡托投影
# 以下三行为生成CPT颜色文件的代码
incpt=wysiwyg
cptf=GMT_complexFig.cpt
gmt makecpt -C$incpt -T-7000/0/1400 -D -V -F -Z > $cptf
```
wysiwyg是GMT自带的CPT，但是需要根据数据范围和作图要求重新配置需要的CPT文件。除了wysiwyg外，大家还可以尝试haxby和globe等GMT自带颜色文件，都是比较适合画地形图的。
这就是画图需要定义的一部分，我一般会把它们放最前面，调试时候比较好找。以上工作就相当于准备好了画图需要的画板、颜料以及地图的格式和框架，下面的工作就是 just do it！

### 开始画图——底图
```
gmt begin $fig_name $fig_fmt 
```
首先是gmt begin，这是GMT6的代码风格，后面还会看到更多与GMT5不同的地方
```
gmt grdimage $inf -I$gradf -R$R -J$J -CGMT_complexFig.cpt -Bx10f5 -Bya10f5 
-BWseN 
```
这是底图，可以说是很简单了吧？
```
gmt coast -Sgray -A0 -t70 -V 
gmt coast -Ggray -A1000
```
看到这里是不是很纳闷为什么要用两次海岸线模块？第一行对底图本身没有添加任何线条，但是加上后会让图变得高级，本质上是在底图之上加了一层70%（可随意调整）透明的灰色（即高级灰）。底图就成了传说中的“莫兰迪色”，常用于各种家居设计以及《延禧攻略》。第二行为普通的海岸线模块，将陆地填充灰色。
```
gmt psscale -C$cptf -Ba2000f1000/:"  Depth (m)": -D4/-0.5/8/0.4h -I # 色卡
gmt basemap -Lfx15/-0.5/-38/500+u # 比例尺，此处为500km
```
最终获得的底图如下
![GMT_compleFig_bottom.png](https://raw.githubusercontent.com/mantle-754/GMT_share/master/20181110GMT_complex/FIGmaker/GMT_compleFig_bottom.png?token=Ap7MLw4DleSYO9d2ctHV-dhor9exjnGoks5b-R4FwA%3D%3D)
现在地形图的基本框架已经打好了，可以在此基础上随意添加各种想要的元素。
### 添加点、线、面
```
# 加线
# 洋中脊的脊轴和转换断层
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
```
```
# 加点
# 热液活动和热液异常
gmt psxy hydrothermal/hydrothermal_anomaly.txt -Sc10p -W0.2p,white -Gblue
gmt psxy hydrothermal/hydrothermal_vent.txt  -Sc10p -W0.2p,white -Gred
```
```
# 加面
# 随便假设一个研究区域
echo 43 -40.5 > area
echo 43 -41.5 >> area
echo 45 -41.5 >> area
echo 45 -40.5 >> area
gmt psxy area -Gred  -L -A
rm area
```
![GMT_compleFig_add.png](https://raw.githubusercontent.com/mantle-754/GMT_share/master/20181110GMT_complex/FIGmaker/GMT_compleFig_add.png?token=Ap7ML8TQRK49ODy2SX4XzF90xJC4Ng7pks5b-SETwA%3D%3D)
画到这，是不是感觉已经大功告成了？并没有~~~~因为这张图一点都不复杂，可以发现图的左上和右下角都是空白。
### 图例和地理位置图
画了这么多元素，应当加一些图例以说明，当然也可以在论文中图片下方文字说明，并将之放在右下方。
```
echo 55.5 -51 > legend
echo 55.5 -57 >> legend
echo 75 -57 >> legend
echo 75 -51 >> legend
gmt psxy legend -W1p,black -Gwhite  -L -A
# 此处建立一个图例边框文件，并绘制
echo 56.5 -52 > ridge.legend
echo 59.5 -52 >> ridge.legend
gmt psxy ridge.legend -Wthicker
echo 59.5 -52 ridge | gmt pstext -F+f12+jLM  -D0.3c/0c
# 建立图例文件 并绘制，下同
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
rm legend ridge.legen TF.legend RTJtrace.legend # 删除图例文件
```
最后再把地理位置放在左上方。
```
gmt coast -R-60/300/-90/90 -JG55/-40/6c -A20000 -W0.1p -Gblack -Swhite -Ba30g -V -Y8.25c
# 这里需要说明一下，这里的-R和-J和底图不同，但仍可放置在同一张图中，但是需要调整位置（-Y8.25c，其中8.25是试出来的）
gmt psxy  ridge/SWIR.txt -W0.5p+s -V
gmt psxy  ridge/SEIR.txt -W0.5p+s -V
gmt psxy  ridge/CIR.txt -W0.5p+s -V
gmt psxy  ridge/AAR.txt -W0.5p+s -V
gmt psxy  ridge/slow.txt -W0.5p+s -V
echo 50.1 -37.7| gmt psxy -Sa15p -W0.1p,red -Gred -V
```
成了！

图例部分不详细讲述，因为一般人不会用GMT直接画，更多人会选择CorelDraw之类的画图软件。

