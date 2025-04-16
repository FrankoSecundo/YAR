### Using color in ggplot
# 10 April 2025
# RMJ

library(ggplot2)
library(ggthemes)
library(colorblindr)
library(colorspace)
library(wesanderson)
library(ggsci)
library(tidyverse)

theme_set(theme_bw(base_size = 16))


# make a little vector

my_cols <- c("thistle","tomato","cornsilk","cyan","chocolate")

demoplot(my_cols,"map")
demoplot(my_cols,"bar")
demoplot(my_cols,"scatter")
demoplot(my_cols,"perspective")
demoplot(my_cols,"spine")
demoplot(my_cols,"heatmap")


pokepal <- read.csv(file = "pokemon_col_palette.csv",header = TRUE)

pokepal <- pokepal %>% arrange(Type)

col <- unique(pokepal$Colorhex)

demoplot(col,"bar")
demoplot(col,"map")

# gray function versus gray colors

# built in greays (0=black, 100=white)
my_greys <- c("grey20","grey50","grey80")
demoplot(my_greys,"bar")

my_greys2 <- grey(seq(from=.1,to=.9,length.out=10))

demoplot(my_greys2,"heatmap")


#converting from color to black and white

d <- mpg

p1 <- ggplot(d,aes(x=as.factor(cyl),y=cty,fill=as.factor(cyl)))+geom_boxplot()
p1

# suck the color out of it swwwwwooooooop

p1_des <- colorblindr::edit_colors(p1,desaturate)
plot(p1_des)

# ugh. well they basically look identifcal. Because the intesnity of gray scale is the same

p2 <- p1+scale_fill_manual(values = c("red","green","blue","yellow"))

p2_des <- colorblindr::edit_colors(p2,desaturate)
plot(p2_des)

#ugly in color, beauty in black and white

# using alpha in

x1 <- rnorm(n=100,mean=0)
x2 <- rnorm(n=100,mean=2.7)
d_frame <- data.frame(v1=c(x1,x2))
lab <- rep(c("Control","Treatment"),each=100)
d_frame <- cbind(d_frame,lab)
str(d_frame)

h1 <- ggplot(d_frame)+aes(x=v1,fill=lab)

h1+geom_histogram(position = "identity",alpha=.4,color="black")


## color customizations

scale_fill_manual() #box plots and bars
scale_color_manual() #points and lines

p_fil <- ggplot(d)+aes(x=as.factor(cyl),y=cty,fill=as.factor(cyl))
p_fil+geom_boxplot()

clrs <- c("chocolate","cornsilk","dodgerblue","orange")

p_fil+geom_boxplot()+scale_fill_manual(values = clrs)


# default coor gradient

p_grad <- ggplot(d)+aes(x=displ,y=cty,col=hwy)+geom_point(size=3)

plot(p_grad)

# yucky disgusting. I shall not have it!

p_grad <- ggplot(d)+aes(x=displ,y=cty,col=hwy)+geom_point(size=3)+scale_color_gradient(low = "deeppink",high = "black")

plot(p_grad)

# ok now that is a hotass graph!
# maybe not useful but it IS sexy

#please sir may I have another!?

p_grad <- ggplot(d)+aes(x=displ,y=cty,col=hwy)+geom_point(size=3)+scale_color_gradient2(low = "deeppink",mid="chartreuse",high = "black",midpoint=mid)
plot(p_grad)

p_grad <- ggplot(d)+aes(x=displ,y=cty,col=hwy)+geom_point(size=3)+scale_color_gradientn(colors = c( "deeppink","chartreuse","black"))
plot(p_grad)

library(wesanderson)

print(wes_palettes)

demoplot(wes_palettes$GrandBudapest2,"pie")

library(RColorBrewer)
display.brewer.all()

# i actually think the sequential ones are a little ugly.....

library(scales)

show_col(col)


#that bitch viridis

xvar <- 1:30
yvar <- 1:5
mydata <- expand.grid(xvar=xvar,yvar=yvar)

zvar <- mydata$xvar+mydata$yvar+2*rnorm(n=150)

mydata <- cbind(mydata,zvar)

ggplot(mydata)+aes(x=xvar,y=yvar,fill=zvar)+geom_tile()+scale_fill_viridis_c()

ggplot(mydata)+aes(x=xvar,y=yvar,fill=zvar)+geom_tile()+scale_fill_viridis_c(option = "inferno")

ggplot(mydata)+aes(x=xvar,y=yvar,fill=zvar)+geom_tile()+scale_fill_viridis_c()
