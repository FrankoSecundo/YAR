### ggplot IV
# 8 April 2025
# RMJ

### More ggplot somehooooOOOOoooooowwwwwww

library(ggplot2)
library(ggthemes)
library(colorspace)
library(wesanderson)
library(ggsci)
library(colorblindr)

#we are going to get some new r packages!

library(ggridges)
library(ggbeeswarm)
library(GGally)
library(ggpie)
library(ggmosaic)
library(scatterpie)
library(waffle)
library(DescTools)
library(treemap)

color = grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]

pal.n20 <- sample(color, 20)

theme_set(theme_bw(base_size = 17))

d <- mpg

# violin plots

p1 <- ggplot(data = d)+aes(x=drv,y=cty,fill=drv)+geom_violin()+scale_fill_manual(values = pal.n20)
p1

# violin plot with points

p1 <- ggplot(data = d)+aes(x=drv,y=cty,fill=drv)+geom_violin()+geom_point(position = position_jitter(width = .2,height = .3),color="black",size=.4)+scale_fill_manual(values = pal.n20)
p1


#ridgeline plot

p2 <- ggplot(data = d)+aes(x=cty,y=drv,fill=drv)+ggridges::geom_density_ridges(alpha=.3)+ggridges::theme_ridges()+scale_fill_manual(values = pal.n20)
p2

# beeswarm plot

p3 <- ggplot(data = d)+aes(x=cty,y=drv,color=drv)+ggbeeswarm::geom_beeswarm(method = "center",size=2)+scale_color_manual(values = pal.n20)
p3

#bubble plot

p4 <- ggplot(data = d)+aes(x=displ,y=hwy,fill=drv)+geom_point(shape=21,color="black",stroke=.5)+scale_color_manual(values = pal.n20)
p4

# parallel coordinates plot
# note that this requires the specific column number not the names
#this will rescale everything to the same scale. they are spread apart based on the numerical value between
# for the same sample this shows where the coordinates are for eahc variable

p5 <- GGally::ggparcoord(data = d,columns = c(3,9),groupColumn = 7)
p5

# Lollipop plot

# first look at the data

table(d$fl)

# we need to do some data reorganization

fuel_data <- data.frame( table(d$fl),fuel=c("Natural Gas", "Diesel","Ethanol","Premium","Regular"))

fuel_data <- fuel_data[,-1]
fuel_data$Freq <- fuel_data$Freq+100

p6 <- ggplot(data = fuel_data)+aes(x=fuel,y=Freq)+geom_segment(aes(x=fuel,xend=fuel,y=0,yend=Freq),color="black",linewidth=2)+geom_point(color="deeppink",size=7)+labs(title="Fuel Type",x="",y="Count")+coord_flip()+theme_light(base_size = 16,base_family = "Monaco")+theme(panel.grid.major.x = element_blank(),panel.border = element_blank(),axis.ticks.y = element_blank(),plot.title.position = "plot",plot.title = element_text(hjust = 0))


# oh shit.
# oh no
# fuck
# pie charts
# disgusting
# vile

p7 <- ggpie::ggpie(data = mpg,group_key = "class",count_type = "full",label_info = "ratio",label_type = "circle")
p7

# EWWWW omggggg absolutely not!

# make it better or kill it

# waffles are better

# first put the data in tabled form

td <- as.data.frame(table(class=mpg$class))

p8 <- ggplot(data = td)+aes(fill=class,values=Freq)+waffle::geom_waffle(n_rows = 8,size=.33,color="black")+coord_equal()+theme_void()+scale_fill_manual(values = pal.n20)
p8


# Scatterpie!

# first make a lil data frame

d <- data.frame(x=rnorm(5),y=rnorm(5))
d$A <- abs(rnorm(5,sd=1))
d$B <- abs(rnorm(5,sd=2))
d$C <- abs(rnorm(5,sd=3))

p9 <- ggplot(data=d)+scatterpie::geom_scatterpie(aes(x=x,y=y),pie_scale = 1:5,cols = c("A","B","C"))+coord_fixed()+scale_fill_manual(values = c("coral","grey95","black"))
p9

## now time for some artsy shit

# mosaic plots

# make a new dataframe.
#the expand grid makes the combination of all the strings

city_tree <- expand.grid(Tree=c("Oak","Pine","Maple","Spruce","Beech"),City=c("Bur","Col","Win"))

city_tree$Freq <- sample(1:100,size = 15)

#this repeats everything by the frequency

city_tree_long <- DescTools::Untable(city_tree)
d <- city_tree_long

p10 <- ggplot(data = city_tree_long)+geom_mosaic(aes(x=product(Tree,City),fill=Tree),divider = mosaic("v"))+labs(title = 'Tree Type')
p10


#factor conditioning

p13 <- ggplot(data = d)+geom_mosaic(x=product(Tree),fill=Tree,conds=product(City))

# treemaps

m <- mpg

m2 <- as.data.frame(table(Fuel=m$fl,Drive=m$drv))

m2
m2$Fuel <- rep(c("Compressed Gas","Diesel","Ethanol","Premium","Regular"),each=3)

m2$Drive <- rep(c("Four Wheel","Front Wheel","Rear Wheel"),each=5)

treemap(dtf=m2,index = "Fuel",vSize = "Freq",type = "index")

treemap(dtf=m2,index =c( "Fuel","Drive"),vSize = "Freq",type = "index")

treemap(dtf=m2,index = c("Drive","Fuel"),vSize = "Freq",type = "index")



