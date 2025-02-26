# For Loops
# 18 February 2025
# RMJ

#OHHHHHH YOU DONE IT NOW!!! YOU DUG TO DEEP AND HIT THE FOR LOOP!
#TOO LATE YOU CAN'T ESCAPE
# LETS DIG IN!

# anatomy of a for loop

for (var in seq) { # start of for loop

  #body of for loop


  } # end of the for loop

#######

# for the var use i, j, or k as a matter of practice

#this code will run the code 5 times. i will increase by 1 each time

for ( i in 1:5) {

  cat("gurl help, i'm stuck in a for loop","\n")
  cat(3+2,"\n")
  cat(runif(1),"\n")
}

print(i) #interestingly the value of i is the last variable that we ran

my_dawgs <- c("chow","shepherd","husky","golden","magic")

for(i in 1:length(my_dawgs)){

  cat("i=",i,"my_dawgs[i]=", my_dawgs[i],"\n")


}

#won't work because there are no bad dogs


my_bad_dogs <- NULL

for(i in 1:length(my_bad_dogs)){

  cat("i=",i,"my_dawgs[i]=", my_dawgs[i],"\n")
}

#we don't always need a for loop

# this can be done as a line

for (i in 1:length(my_dawgs)){
  my_dogs[i] <- toupper(my_dawgs[i],"\n")

}

#like this

my_dogs <- toupper(my_dawgs)

#

# or this

my_dat <- 1:10
for(i in seq_along(my_dat)){
  my_dat[i] <- my_dat[1]+my_dat[i]^2
  cat("Loop number =", i, "vector element=", my_dat[i])

}

#note that we have to be cognizant when our counter is an integer
# this is why using length is important


z <- c(10,2,4)

for(i in 1:length(z)){
  cat("the value of i=",i,"z[i]=", z[i],"\n")
}

######################## February 20th ######################

# more for loops

# introducing Next

z <- 1:20

#note this gives you the number
16/5

#and this is integer division aka the WHOLEass number without the remainder

16 %/% 5

#and this would give you the remainder

16 %% 5

#this lets you ONLY do the odd numbers

for(i in seq_along(z)){
  if(i %% 2==0) next # what next does is immediately skip to the bottom of the sequence or jump to the next iteration of the loop. this occurs when it is TRUE basically when true it jumps to the next sequence

  print(i)

}

#we can do the same for the evens

for(i in seq_along(z)){
  if(i %% 2==1) next # what next does is immediately skip to the bottom of the sequence or jump to the next iteration of the loop. this occurs when it is TRUE basically when true it jumps to the next sequence

  print(i)

}

#this is just another way to do the same thing

for(i in seq_along(z)){
  if(i %% 2 != 0) next # what next does is immediately skip to the bottom of the sequence or jump to the next iteration of the loop. this occurs when it is TRUE basically when true it jumps to the next sequence

  print(i)

}

#we don't need a for loop necessarily. this can be done faster with just code

z <- 1:20

zsub <- z[z %% 2 != 0]

length(zsub)
print(zsub)


for (i in seq_along(zsub)) {
  cat("i= ",i,"zsub[i]=",print(zsub[i]))

}

# Introducing the break function

# the break function is a way of exiting a loop early


###################################################
# Function: run_walk
#stoachastic random walk
# input times= number of time steps
# n1 = initial population size (= n[1])
# lambda = finite rate of increase (fun fact, if we have a lamda > 1 then it is VERY likely biological in origin)
# noise_sd = sd of a normal distribution with mean 0
# output: vector n with population size > 0 until extinction, then NA

library(ggplot2)

theme_set(theme_bw(base_size = 16))

run_walk <- function(times=100,n1=50,lambda=1.00,noise_sd=10) {
  n <- rep(NA,times) # create output vector
  n[1] <- n1 #initialize with starting population size
  noise <- rnorm(n=times,mean = 0,sd=noise_sd) #create noise vector

  #this is the start of the loop, note that the loop terminates at the second to the last element. this is because we are always calculating the next element in the vector

  for(i in 1:(times-1)) {
    n[i+1] <- lambda*n[i] +noise[i]
    if(n[i+1]<=0) {
      n[i+1] <- NA
      cat("Population extinction at time", i+1,"\n")
      break}

  }

  return(n)

}
run_walk()

#and to plot this we can use qplot which is an offshoot of ggplot

qplot(x=1:100,y=run_walk(),geom = "line")


#Now lets run some test cases to see if we can break this mothah

qplot(x=1:100,y=run_walk(noise_sd = 0),geom = "line")

#this *should* give us a flat line because there is no longer a mechanism of increase or decrease. thus this means that that part of the code is functioning correctly


qplot(x=1:100,y=run_walk(noise_sd = 0,lambda = 1.1),geom = "line")

#this should cause a smooth exponential increases with a 10% addition at every time step

qplot(x=1:100,y=run_walk(noise_sd = 0,lambda = 0.98),geom = "line")

#and this one should be a steady decrease


############ DOUBLE FOR LOOPSSSSSSSSS ###########

#theyre like double rainbows but not gay. Which is a failing on them

#this will run through all the rows

m <- matrix(round(runif(20),digits = 2),nrow = 5)

for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + i
}

print(m)

#this will run through all the columns

m <- matrix(round(runif(20),digits = 2),nrow = 5)

for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + j
}

print(m)

#and this will then loop through the rows and the columns

m <- matrix(round(runif(20),digits = 2),nrow = 5)
for(i in 1:nrow(m)) {
  for(j in 1:ncol(m)){
    m[i,j] <- m[i,j] + i + j
  }
}

print(m)

#################### Species area function ################


# function: Speciesareacurve
# creates power function relationship for S and A
# input: A is a vector of island areas
# c is the intercept constant
# z is the slope
# output: S is a vector of species richness values

species_area_curve <- function(A=1:5000,c=0.5,z=0.26){
  S <- c*(A^z)
  return(S)
}

head(species_area_curve())


############### Species are plot ######################

# function: species_area_plot
# plot species area curves with parameter values
# input: A = vector of areas
# c = single value for c parameter
# z= single value for z parameter
#output: smoothed curve with parameters in graph


species_area_plot <- function(A=1:5000,c=0.5,z=.26){
  plot(x=A,y=species_area_curve(A,c,z),type="l",xlab="Island Area",ylab="S",ylim=c(0,2500))
  mtext(paste("c=",c," z=",z),cex = 0.7)
}

species_area_plot()

c_pars <- c(100,150,175)
z_pars <- c(0.10,0.16,0.26,.3)

par(mfrow=c(3,4))
for(i in seq_along(c_pars)){
  for(j in seq_along(z_pars)){
    species_area_plot(c=c_pars[i],z=z_pars[j])
  }
}
