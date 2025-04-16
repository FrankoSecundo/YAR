### ggplot II
# 1 april 2025
# RMJ

library(ggplot2)
library(ggthemes)
library(patchwork)

theme_set(theme_bw(base_size = 17))

d <- mpg

color = grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]

pal.n20 <- sample(color, 20)

g1 <- ggplot(data=d)+aes(x=displ,y=cty)+geom_point()+geom_smooth()
print(g1)


g2 <- ggplot(data=d)+aes(x=displ,y=cty,group = displ)+geom_boxplot()
print(g2)

g3 <- ggplot(data=d)+aes(x=displ)+geom_histogram(fill="dodgerblue")
print(g3)

g4 <- ggplot(data=d)+aes(x=displ,y=cty,group = displ)+geom_bar(stat="identity")

# change the columns
g1+g2+g3+plot_layout(ncol = 1)

#change the relative areas

g1+g2+g3+plot_layout(ncol = 1,heights = c(2,1,1))

#makes the second column wider

g1+g2+g3+plot_layout(ncol = 2, widths = c(1,2))

#we can also add a spacer

g1+plot_spacer()+g2

# we can even do some nesting that didn't quite work thoguh....

g1 + {
  g2 + {
    g3 + plot_layout(ncol = 1)
  }
}


# we can order things

g1 + g2 - g3+ plot_layout(ncol = 1)

# the minus sign puts it below


# / and | for intuitive layout

(g1 | g2 | g3)/g4

# add titles and stuff

g1 + g2 + g3 + plot_annotation('This is my widdle title', caption = 'made with patchwork but I did most of it....jk', theme = theme(plot.title = element_text(size=17)))

# we can add letters wholy shit this is a game changer

g1 + g2 +g3 +plot_annotation(tag_levels = 'A')

# we can reverse it!

g3a <- g3+scale_x_reverse()
g3b <- g3+scale_y_reverse()
g3c <- g3+scale_x_reverse()+scale_y_reverse()

(g3 | g3a)/(g3b | g3c)

(g3+coord_flip()|g3a+coord_flip())/(g3b+coord_flip() | g3c + coord_flip())


ggsave(filename = "myplot.pdf",plot = g3,device = 'pdf',width = 20,height = 20,units = "cm",dpi = 300)



################# basics of mapping aesthetic variables


# color by class
m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,color=class)+geom_point(size=3)+scale_color_manual(values=pal.n20)
print(m1)

# shape by class
m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,shape=class)+geom_point(size=3)
print(m1)

### ooo no no mapping the size to a discrete
m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,size=class)+geom_point()
print(m1)


#mapping a continuous variable to a point size

m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,size=hwy)+geom_point()
print(m1)

# mapping continuous variable to color

m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,color=hwy)+geom_point(size=5)+scale_color_viridis_c()
print(m1)

# we can map ANYTHING onto ANYTHING

m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,shape=drv,colour = fl,size = hwy)+geom_point(size=5)+scale_color_manual(values = pal.n20)

print(m1)



m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,colour = drv)+geom_point(size=2)+geom_smooth(method = "lm")+scale_color_manual(values = pal.n20)
print(m1)

# faceting

m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,colour = class)+geom_point(shape=21)+facet_grid(class~fl)+scale_color_manual(values = pal.n20)
print(m1)

m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,colour = class)+geom_point(shape=22)+facet_grid(class~fl,scales = "free_y")+scale_color_manual(values = pal.n20)
print(m1)

m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,colour = class)+geom_point(shape=21)+facet_grid(class~fl)+scale_color_manual(values = pal.n20)
print(m1)

 # one variable faceting

m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,colour = class)+geom_point(shape=21)+facet_grid(class~.)+scale_color_manual(values = pal.n20)
print(m1)


# facet wrap

# if you add an additional classifying variable it will make all the combinations of the groups!

m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,colour = class)+geom_point(shape=21)+facet_wrap(~class+fl)+scale_color_manual(values = pal.n20)
print(m1)

# but it drops the ones that are missing. we can bring them back

m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,colour = class)+geom_point(shape=21)+facet_wrap(~class+fl,drop = FALSE)+scale_color_manual(values = pal.n20)
print(m1)


# use facet with other aesthetic mapping within rows or columns

m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,colour = drv)+geom_point(shape=21)+facet_wrap(.~class)+scale_color_manual(values = pal.n20)
print(m1)

m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,colour = drv)+geom_smooth(se=FALSE,method="lm")+scale_color_manual(values = pal.n20)+facet_grid(.~class)
print(m1)

#

m1 <- ggplot(data = mpg)+aes(x=displ,y=cty,group = drv,fill = class)+geom_boxplot()+scale_fill_manual(values = pal.n20)+facet_grid(.~class)
print(m1)


#######

p1 <- ggplot(data=d)+aes(x=displ,y=hwy)+geom_point()+geom_smooth()
print(p1)

# effect of group

p1 <- ggplot(data=d)+aes(x=displ,y=hwy,group = drv)+geom_point()+geom_smooth()
print(p1)

p1 <- ggplot(data=d)+aes(x=displ,y=hwy,color=drv)+geom_point()+geom_smooth()+scale_color_manual(values = pal.n20)
print(p1)

# remember fill is when there is area
# color is for points

p1 <- ggplot(data=d)+aes(x=displ,y=hwy,fill=drv)+geom_point()+geom_smooth()+scale_color_manual(values = pal.n20)
print(p1)

# subsetting

#this will only show the points that have drv==4

p1 <- ggplot(data=d)+aes(x=displ,y=hwy,color=drv)+geom_point(data = d[d$drv=="4",])+geom_smooth()+scale_color_manual(values = pal.n20)

p1 <- ggplot(data=d)+aes(x=displ,y=hwy)+geom_point(aes(colour = drv))+geom_smooth()+scale_color_manual(values = pal.n20)
print(p1)

## eliminating some data

# everything BUT when the drive type = 4. no four wheel drive

p1 <- ggplot(data=d[d$drv!="4",])+aes(x=displ,y=hwy,color=drv)+geom_point()+geom_smooth()+scale_color_manual(values = pal.n20)
print(p1)
