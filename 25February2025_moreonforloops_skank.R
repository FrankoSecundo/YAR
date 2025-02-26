# More for loops and maybe probability distribution
# 25 February 2025
# RMJ




##############


# bring back the species area curve function and plot

species_area_curve <- function(A=1:5000,c=0.5,z=0.26){
  S <- c*(A^z)
  return(S)
}

species_area_plot <- function(A=1:5000,c=0.5,z=.26){
  plot(x=A,y=species_area_curve(A,c,z),type="l",xlab="Island Area",ylab="S",ylim=c(0,2500))
  mtext(paste("c=",c," z=",z),cex = 0.7)
}

c_pars <- c(100,150,175)
z_pars <- c(0.10,0.16,0.26,.3)

#this gives us a specific number of rows and columns in the base plotting of R
#this is why it is inefficient

par(mfrow=c(3,4))

for(i in seq_along(c_pars)){
  for(j in seq_along(z_pars)){
    species_area_plot(c=c_pars[i],z=z_pars[j])
  }
}

#this resets the base graphics in R to have the default of rows

par(mfrow=c(1,1))

###### Looping with While or Repeat

#setting up some global variables

cut_point <- 0.1
z <- NA


ran_data <- runif(100)
for(i in seq_along(ran_data)){
  z <- ran_data[i]
  if(z < cut_point) break

}

#basically this is going to run until it gets to a number higher than .1
print(z)

#this tells us how many loops it took
print(i)

##### looping with while

z <- NA
cycle_number <- 0

while(is.na(z) | z >= cut_point) {
  z <- runif(1)
  cycle_number <- cycle_number + 1

}
print(z)
print(cycle_number)

#NEVER USE THIS AGAIN! IT IS FORBODEN! mostly because you have to use complex boolean statements. Its also inefficient to call functions within loops. And its pretty easy to get into a veeerrrryyyy long loop. Without good criteria, it won't stop.


#the expand grid function (wish someone would expand my grid nowhatimsayun)

# we're going to harken back to z and c pars we made.
#expand grid will automatically create all the pairings of the unique combinations of the parameters.

expand.grid(c_pars,z_pars)

df <- expand.grid(c_pars=c_pars,z_pars=z_pars)

head(df)


##############################

## new function Species Area Function

sa_output <- function(S=runif(10)){
  sum_stats <- list(s_gain=max(S)-min(S),s_cv=sd(S)/mean(S))

  return(sum_stats)
}

sa_output()


# build program body with a single loop through the parameters in modelframe

# global variables
area <- 1:5000
c_pars <- c(100,150,175)
z_pars <- c(0.10,0.16,0.26,0.3)

# set up model frame

model_frame <- expand.grid(c=c_pars,z=z_pars)
model_frame$s_gain <- NA
model_frame$s_cv <- NA
print(model_frame)


for (i in 1:nrow(model_frame)){

  temp1 <- species_area_curve(A=area,c=model_frame[i,1],z=model_frame[i,2])

  temp2 <- sa_output(temp1)

  model_frame[i,c(3,4)] <- temp2
}

print(model_frame)


########## Parameter sweeping redux with ggplot

library(ggplot2)

area <- 1:5
c_pars <- c(100,150,175)
z_pars <- c(0.10,0.16,0.26,0.3)

#
model_frame <- expand.grid(c=c_pars,z=z_pars,A=area)
model_frame$S <- NA


### Method 1 with a for loop

for( i in 1:length(c_pars)){
  for(j in 1:length(z_pars)){
    model_frame[model_frame$c==c_pars[i] & model_frame$z==z_pars[j],"S"] <- species_area_curve(A=area,c=c_pars[i],z=z_pars[j])
  }
}

model_frame

### Method 2 also a for loop but better

for(i in 1:nrow(model_frame)){
  model_frame[i,"S"] <- species_area_curve(A=model_frame$A[i], c=model_frame$c[i],z=model_frame$z[i])
}

head(model_frame)

### now we plot them

theme_set(theme_dark())

ggplot(data = model_frame)+geom_line(mapping = aes(x=A,y=S))+facet_grid(c~z,scales = "free")

ggplot(data = model_frame)+geom_line(mapping = aes(x=A,y=S,group = z))+facet_grid(.~c,scales = "free")

ggplot(data = model_frame)+geom_line(mapping = aes(x=A,y=S,group = c))+facet_grid(z~.,scales = "free")
