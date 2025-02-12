# Functions
# 11 February 2025
# RMJ


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

