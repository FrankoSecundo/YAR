### ggplot III
# 3 April 2025
# RMJ

### More ggplot

devtools::install_github("wilkelab/cowplot")
install.packages("colorspace",repos = "http://R-Forge.R-project.org")
install_github("clauswilke/colorblindr",force = TRUE)
library(devtools)

library(ggplot2)
library(ggthemes)
library(colorspace)
library(wesanderson)
library(ggsci)
library(colorblindr)

theme_set(theme_bw(base_size = 17))

color = grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]

pal.n20 <- sample(color, 20)

d <- mpg

table(d$drv)

p1 <- ggplot(d)+aes(x=drv,fill=fl)+geom_bar()

print(p1)

# now lets play with color!

# remember that alpha is transsparency 0-invisible<----------->1-saturated

p1 <- ggplot(d)+aes(x=drv,fill=fl)+geom_bar(alpha=0.3,position = "identity")

# position fill will rescale

p1 <- ggplot(d)+aes(x=drv,fill=fl)+geom_bar(alpha=1,position = "fill")

print(p1)

# multiple bars

p1 <- ggplot(d)+aes(x=drv,fill=fl)+geom_bar(alpha=1,position = "dodge",color="black")+scale_fill_manual(values = pal.n20)
print(p1)

d_tiny <- tapply(X=d$hwy,INDEX=as.factor(d$fl),FUN=mean)

# this takes in data, grouping variable, and then the name of a function that will be applied

print(d_tiny)

str(d_tiny)
#apparently it is a numeric vector. this is UNACCEPTABLE!!!

d_tiny <- data.frame(hwy=d_tiny) # create a single column data frame

print(d_tiny)

d_tiny <- cbind(fl=row.names(d_tiny),d_tiny)
print(d_tiny)

p2 <- ggplot(d_tiny)+aes(x=fl,y=hwy,fill=fl)+geom_col()
print(p2)

#baisc box plot is snazzy and sexy

p1 <- ggplot(d) + aes(x=fl,y=hwy,fill = fl)+geom_boxplot()+geom_jitter()+scale_fill_manual(values = pal.n20)

print(p1)
