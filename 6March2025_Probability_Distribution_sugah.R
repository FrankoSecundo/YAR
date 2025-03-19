# Probability Distribution
# 6 March 2025
# RMJ


# the probability distribution is the shape of the variance and the mean in regards to series of data points

# essentially it shows how likely certain values are

# we can also measure skewness by cubing the variance

# note a long right skew is a positive skew
# a lone left tail is a negative skew

# if you take it to the 4th this is the chunk meter aka kurtosis which describes how THICC the skew tail is

##### Discrete Distributions #####

# have probability mass (bar aka finite) the probability of the sum of the bars should equal 1

# poisson
# binomial
# negative binomial

##### Continuous Distributions #####

# have probability density (point cloud presenting an infinitely small area), the sum of the area under the curve should equal 1

# usually what we care about the most is the area under the curve, not the height of the bump. The area can tell us things like "is this value extreme?" and the area will tell you the chances of getting that value or a large or smaller value (depending on which direction you go)

# a probability density function can be drawn as a cumulative distribution function when the y axis is 0-1 instead, the y represents the cumulative area as you move from left to right. The curve should look a bit like the exponential and then lag phase as we cross over the hump



# Uniform
  # has 2 values that are needed to build the distribution needed:(minimum, maximum)
# normal
  # it must have the following parameters (mean, variance)
# continuous
# beta
# gamma

############# Probability Distributions in Action ###################

# load libraries

library(ggplot2)

theme_set(theme_bw(base_size = 16))

my_histo <- function(x=NULL){
  if(is.null(x)) df=data.frame(x=runif(1000)) else df <- data.frame(x=x)
  p1 <- ggplot(data = df)+
    aes(x=x) + geom_histogram(color="black",fill="goldenrod")
  print(p1)
}

my_histo()

#-------------------------------------------##### Poission distribution ######

# Poisson distribution

# we need another library

library(MASS)

# poisson distribution is discrete and bounded (cannot be less than 0 but it can be infinitely big)
# random events with a constant rate lambda
# observation per time or per unit area
# parameter lambd > 0
# essentially lambda is telling you what are the chances of getting a positive hit

# note: "zero-inflated poisson' has an additional process generating zeroes (see ifelse)
# note: "Zero-censored poisson" occurs when zeroes are not recorded


hits <- 0:10
myVec <- dpois(x=hits,lambda = 1) #calling the probability mass function using the average rate of 1 (1 event per sampling unit)

my_histo(myVec)
plot(myVec, type = "b")


myVec <- dpois(x=hits,lambda = 2) #calling the probability mass function using the average rate of 2 (2 events per sampling unit)
plot(myVec, type = "b")

myVec <- dpois(x=hits,lambda = 10) #calling the probability mass function using the average rate of 2 (2 events per sampling unit)
plot(myVec, type = "b")

#what if we want to go bigger?

hits <- 0:30
myVec <- dpois(x=hits,lambda = 20) #calling the probability mass function using the average rate of 2 (2 events per sampling unit)
plot(myVec, type = "b")

# interesting, this isn't enough to get a full profile

hits <- 0:50
myVec <- dpois(x=hits,lambda = 20) #calling the probability mass function using the average rate of 2 (2 events per sampling unit)
plot(myVec, type = "b")

#note that lambda does not have to be a whole number it can be 15.5 for example

my_histo(myVec)

# now we cna create a density

sum(myVec) #it better be 1........it is

head(myVec)

# lets use ppois instead

hits <- 0:10

myVec <- ppois(q=hits,lambda = 2)

plot(myVec,type = "b")


# for a poisson distribution with lambda=2 what is the probability of getting 1 or fewer hits

ppois(q=1,lambda = 2)

# we could also get this through dpois

p_0 <- dpois(x=0,lambda = 2)
p_0
p_1 <- dpois(x=1,lambda = 2)
p_1
p_0+p_1


# qpois is for quantile
# the q function is the inverse of p
# what is the number of hits corresponding to 50% of the probability mass

qpois(p=.5,lambda = 2.5)

# 2 is the answer indicating that we would need to have two hits I think

# this is the rpois function which generates random values

# set seed

set.seed(666)

ranPois <- rpois(n=1000,lambda = 2.5)
my_histo(ranPois)



########### Quantile function ############

# for real or simulated data we can use the quantile function to find the empirical 95% confidence interval on the data

quantile(x=ranPois,probs = c(0.025,0.975))



########### Binomial Distribution ###############


# binomial distribution
# p = the probability of a dichotomous outcome (TRUE or FALSE)
# size = number of trials
# x = possible outcomes
# outcome x is bounded between 0 and number of trials

# use "d" binom for density function

hits <- 0:10
myVec <- dbinom(x=hits,size=10,prob = .5)
plot(myVec,type = "b")

myCoins <- rbinom(n=5000,size = 100,prob = .5)

plot(myCoins,type = "b")

my_histo(myCoins)

quantile(x=myCoins,probs = c(0.025,0.975))


################### Negative Binomial ######################

# negative binomial: number of failures (values of MyVec)
# in a series of Bernouli with p=probabilty of success
# before a target number of successes (= size)
# generates a discrete distribution that is more
# heterogeneous ("overdispersed") than Poisson

hits <- 0:40
myVec <- dnbinom(x=hits,size = 5,prob = .5) # we want 5 succcesses each with a probability of .5

plot(myVec,type = "b")

#the results will show that it takes about 6 times to get 5 successes in a row

# geometric series is a special case where N-1 success
# each bar is a constant fration 1- "prob" of the bar before it

myVec <- dnbinom(x=hits,size=1,prob = .1)
plot(myVec,type = "b")
