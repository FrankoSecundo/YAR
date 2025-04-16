# ggplot graphics!
# RMJ
# 27 March 2025
#


# we are going to make sexy graphs that will bring all the boys, girls, and enbys to the yard.

# bring those hawt libraries in

library(ggplot2)
library(ggthemes)
library(patchwork)

color = grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]

pal.n20 <- sample(color, 20)

# the general ggplot structure

# p1 <- ggplot(data=<DATA>)+aes(<MAPPINGS>)+<GEOM_FUNCTION>(aes(<MAPPINGS>),stat=<STAT>,position=<POSITION>)+<COORDINATE_FUNCTION>+<FACET_FUNCTION>

# p1 is the output plot (don't do this until the end, otherwise you'll have to make it and print it again and again.

# basically data= dataframe of your stuff, aes=asthetics, how it will look and Mappings= where your data will do, geom_function= the type of graph, stat= how the data are calculated, position=how they are positioned e.g. horizontal, vertical, coordinate function=if you want to rearrange the coordinate

# oh and the facte makes it so we can subdivide the data into smaller ones

# ggsave is a way to save your plot output in a consistent way

# example ggsave(plot=p1, filename="myplot",width=5,height=5,units="px",device="pdf")

# personally the first thing I do is change the theme of ggplot because the default is yucky disgusting

# set theme to the black and white theme with a base font of 16

theme_set(theme_bw(base_size = 16))

#we will bring in a built in dataset called mpg, we will save it as d so we have to type less. Sloth is the best sin

d <- mpg

# take a peak

str(d)

# a nice mix of continuous and discreet data

# remember since it is a dataframe you can call data by name with a $

table(d$fl)

# we can make a basic histogram very easily using the basic skeleton

ggplot(data = d)+aes(x=hwy)+geom_histogram() # note that once we tell it which data we are using ggplot will figure out the columns automatically if we tell them the name like hwy.

# cute. but boring

# let's make it hot

ggplot(data = d)+aes(x=hwy)+geom_histogram(color="black",fill="magenta")

# the color is the bar outline and the fill is the....fill...the innards...what we stuff it with

# anyway, now the plot is sexy blackpink

# there are LOTS of geoms, one for every occasion, like what if we wanted a histogram but curvy?

# thats called a density plot you little gremlin

# same basic code though but change geom

ggplot(data = d)+aes(x=hwy)+geom_density(color="black",fill="palegreen")

# and we can make scatter plot of course but we need to add a y variable as well

ggplot(data = d)+aes(x=displ,y=hwy)+geom_point(color="sienna")

# we can also layer geoms if they are compatible. like adding a smooth trendline or spline

ggplot(data = d)+aes(x=displ,y=hwy)+geom_point(color="sienna")+geom_smooth()

# note this is a curve that is fitted using the local data but is pretty damn arbitrary. we adjust the parameters and essentially get it to fit the way we want which is not good since it isn't statistically valid. Helpful to visualize trends BUT do not use it like its an equation

# we can fix this by adding an actual method based in a model

ggplot(data = d)+aes(x=displ,y=hwy)+geom_point(color="sienna")+geom_smooth()+geom_smooth(method="lm",col="orange")

# now that actually is based in real data

# we can also make box plots. note that the x variable MUST be discrete

ggplot(data = d)+aes(x=fl,y=cty)+geom_boxplot(aes(fill = fl),color="black") # ntoe that if you want to color by a variable you need to put it as an asthetic

# basic bitch barplots

ggplot(data = d)+aes(x=fl)+geom_bar(fill="olivedrab2",color="black")

# bar  plot with specified counts or means

# we will make some data

x_treatment <- c("Control","Low","High")
y_response <- c(12,2.5,22.9)
summary_data <- data.frame(x_treatment,y_response)

ggplot(data = d)+aes(x=x_treatment,y=y_response)+geom_col(fill=c("darkorange3","darkorchid","darkorchid"),col="black")

# we can aslo plot mathematic functions

my_vec <- seq(1,100,by=.1)


d_frame <- data.frame(x=my_vec,y=sin(my_vec))

ggplot(data = d_frame)+aes(x=x,y=y)+geom_line()

# probability density functions, ugh these guys again

d_frame <- data.frame(x=my_vec,y=dgamma(my_vec,shape = 5,scale = 3))

ggplot(data = d_frame)+aes(x=x,y=y)+geom_line()

#we can even plot our own little user defined functions

my_fun <- function(x) sin(x)+.1*x
d_frame <- data.frame(x=my_vec,y=my_fun(my_vec))
ggplot(data = d_frame)+aes(x=x,y=y)+geom_line()


ggplot(data = d)+ (mapping=aes(x=displ,y=cty))+geom_point(color="firebrick")

p1 <- ggplot(data = d)+ (mapping=aes(x=displ,y=cty))+geom_point(color="firebrick")

## now lets eff with some themes to prettify this

p1 + theme_classic(base_size = 16) # no grid lines

p1 + theme_linedraw(base_size = 16) # thick guidelines

p1 + theme_dark(base_size = 16) #feeling emo? only good with bright colors

p1+theme_base(base_size = 16) # this will mimic base R if you want to be sneaky

p1+theme_void(base_size = 16) # just the datapoints.....interesting I suppose you coudl overlay it on something

p1+theme_solarized(base_size = 16) #better for webpages apparently

p1+theme_economist(base_size = 16) # taken from the economist, i think its ugly. No cap

p1+theme_grey(base_size = 16) # the default ewwwwwwwwwwwwwwwwww

############################### 1 April 2025 #########################


# playing around with base size which actually does labels and tick mark

p1+theme_bw(base_size = 30,base_family = "serif")

# note the font families: times, ariel, monaco, courier, helvetica, serif, sans"

library(extrafont)
font_import() # this will bring in All the goddamn fonts in the world apparently. Please only do this once it takes a loooonnnnggg time

# once everything is loaded you can take a peek at all the fonts with


fonts()

# lets try it out

p1+theme_bw(base_size = 30,base_family = "Chalkduster")

# hmmm didn't work we might have to upload it to the system database somehow

# we'll deal with it later


# and we can flip the cooridnates around to get a sidewayz plot

p2 <- ggplot(data = d)+aes(x=fl,fill=fl)+geom_bar()

print(p2)

p2+coord_flip()+theme_bw(base_size = 20,base_family = "sans")

p1 <- ggplot(data = d)+aes(x=displ,y=cty)+geom_point()+labs(title="My graph, i'm so proud of him",subtitle="don't look in the bottom right",x="Displacement",y="City Mileage",caption = "disobediance...nice")
 print(p1)

 p1 <- ggplot(data = d)+aes(x=displ,y=cty)+geom_point(size=4,shape=21,color="black",fill="darkolivegreen")+labs(title="My graph, i'm so proud of him",subtitle="don't look in the bottom right",x="Displacement",y="City Mileage",caption = "disobediance...nice")
 print(p1)

 # change the limits

 p1 <- ggplot(data = d)+aes(x=displ,y=cty)+geom_point()+labs(title="My graph, i'm so proud of him",subtitle="don't look in the bottom right",x="Displacement",y="City Mileage",caption = "disobediance...nice")+xlim(4,7)+ylim(-10,40)
 print(p1)

 #whoops it got clipped, we should do a different limit





