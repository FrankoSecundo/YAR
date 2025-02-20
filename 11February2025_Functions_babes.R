# Functions
# 11 February 2025
# RMJ

library(ggplot2)
theme_set(theme_bw(base_size = 16))

################################ Working with functions like a bitch baby ######################

# there are 3 pieces of a function. the name, the parenthesis, and the input which goes inside the parenthesis

#ex

sum(3,2)

#this is an operator or at leats looks like one BUT SURPRISE it is a function

3+2

'+'(3,2) #does the same thing, what a tramp

y <- 3 # is also a function. WHAT ISN'T A FUNCTION!? cut it open and see if its cake

#if you just type in the name of the function without anything else, you'll get an explanation...sorta.

sd

sd(c(4,5)) #and with input itll run

sd() #occasionally you can get information or itll run based on the defaults but sd is not that kinds of function

# example functionName <- function(parX=defaultX, parY=defaultY, parZ=defaultZ){

#once we are on the inside of the function, the rules of R are the same. also functions can call other functions!

# it can be helpful to have a return statement

return(z) #returns from the function a single element (z could be a list)


#closed curly brack is what ends it. }

##### to test this we will make a function for the Hardy Weinberg Equilibrium


##########################################################
# FUNCTION: hardyweinberg
# input: an allele frequency p (0,1)
# output: p and the frequencies of the 3 genotypes AA, AB, BB

#-------------------------------------------------------------

hardyweingberg <- function(p=runif(1)){

  q <- 1-p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p,AA=fAA,AB=fAB,BB=fBB),digits = 3)

  return(vecOut)

}

#note that when you run it nothing comes out because when you run it the first time, all youre doing is putting it in memory

# but when we run it afterwards we'll get an output!

hardyweingberg()

# we can make new variables to utilize in the function

pp <- 0.6

hardyweingberg(p=pp) #which changes the output

#lets add a function failure statement as well so that it won't work if the value is inappropriate

hardyweinberg2 <- function(p=runif(1)){
  if(p>1.0 | p<0.0) {
    return("Function Failed bitch! P must be >= 0.0 and <= 1.0")
  }

  q <- 1-p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p,AA=fAA,AB=fAB,BB=fBB),digits = 3)

  return(vecOut)

}

#lets check the failure condition

p=3

hardyweinberg2(p=p)
hardyweinberg2(p=-2)

#this works but it isn't actually an error

#redo with stop

hardyweinberg2 <- function(p=runif(1)){
  if(p>1.0 | p<0.0) {
    stop("Function Failed bitch! P must be >= 0.0 and <= 1.0")
  }

  q <- 1-p
  fAA <- p^2
  fAB <- 2*p*q
  fBB <- q^2
  vecOut <- signif(c(p=p,AA=fAA,AB=fAB,BB=fBB),digits = 3)

  return(vecOut)

}

hardyweinberg2(p=p)
hardyweinberg2(p=-2)

###################### 13 February Functions ###################

#scoping in functions, variables that only exist in the function



my_func <- function(a=3,b=4) {

  #note that this also provided default values for a and b in the event that the user does not provide values
  z <- a+b

  return(z)

}

#note that a and b do not appear in the environment

my_func() #output prints to screen

#this is a bad function because it does not provide a default for b. It will source but it will not work

my_func_bad <- function(a=3){
  z <- a+b

  return(z)

}

#so when we run it we get an error which we expect

my_func_bad() #BUT if we make a global variable called b it should work

b <- 100

# try it again

my_func_bad() #now it works!this is because when a function runs it will look inside and outside the function. but this is not good practice because it relies on outside variables

#this one will work because the variables are created internally
my_func_ok <- function(a=3){

  bb <- 100
  z <- a+bb
  return(z)


}

my_func_ok() #zoot zoot, working function

print(bb) #note that this doesn't work because bb exists only inside the function

############################ Simple Functions ###################

#################################

#FUNCTION: Fit linear
# fits simple regression line
# inputs: numerical vector predictor (x) and response (y)
# outputs: slipe and p-value

#--------------------------------------------------
fit_linear <- function(x=runif(100),y=runif(100)){
  my_mod <- lm(y~x) # fit the model
  my_out <- c(slope=summary(my_mod)$coefficients[2,1], p_value=summary(my_mod)$coefficients[2,4])

  p1<- ggplot()+geom_point(aes(x=x,y=y,colour = "blue",alpha=.5,size = 2))
  plot(x=x,y=y)

  return(my_out)

}

#and run it
fit_linear()

###############################

#increasing the complexity, this will make it so if the user does not put in a value it will take a default

fit_linear2 <- function(p=NULL){
  if(is.null(p)){
    p <- list(x=runif(100),y=runif(100))
  }

  my_mod <- lm(p$y~p$x) # fit the model
  my_out <- c(slope=summary(my_mod)$coefficients[2,1], p_value=summary(my_mod)$coefficients[2,4])

  plot(x=p$x,y=p$y)

  df <- data.frame(x=p$x,y=p$y)

  return(my_out)

  p1 <- ggplot(data = df,aes(x=x,y=y))+geom_point(aes(color="blue"),size = 2,alpha = .5)

  return(p1)

}

fit_linear2()

#now lets create some nondefault variables

my_pars <- list(x=1:10,y=sort(runif(10)))

#and run the fit linear 2 with those nondefault remember that p is the only input value we need

fit_linear2(p=my_pars)

####################### do calls


z <- c(runif(99),NA)
mean(z) # this doesn't return an error just an NA so we don't know that th e cause is one NA

#but we can run without NAs
mean(x=z, na.rm = TRUE) #handy

#there is also the trim function which will cut off the extreme ends of the value by a percentile i.e. .01 means the 1 percentile

mean(x=z,na.rm = TRUE,trim = 0.05)

l <- list(x=z,na.rm=TRUE,trim=0.05) #this will bundle the parameters as a list

do.call(mean,l) # the function do.call has two inputs, the name of the function and a list containing the values for all the parameters



