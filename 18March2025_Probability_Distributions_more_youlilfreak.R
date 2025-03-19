# Probability Distributions 2
# 18 March 2025
# RMJ

# Probability distributions in R
# Discrete distributions
# Poisson
# Range: [0,∞
# ]
# Parameters: size = number of events, rate = λ
# Interpretation: Distribution of events that occur during a fixed time interval or sampling effort with a constant rate of independent events; resembles normal with large λ
# , or exponential with small λ
# Binomial
# Range: [0, # of trials]
#         Parameters: size= number of trials; p = probability of positive outcome
#         Interpretation: Distribution of number of successful independent dichotomous trials, with constant p
#         Negative Binomial
#         Range: [0, ∞
#         ]
#         Parameters: size=number of successes; p = probability of success
#         Interpretation: Distribution of number of failures in a series of independent Bernouli trials, each with p = probability of a success. Generates a discrete distribution that is more heterogeneous (“overdispersed”) than Poisson
#         Continuous distributions
#         Uniform
#         Range: [min,max]
#         Parameters: min = minimum boundary; max = maximum boundary
#         Interpretation: Distribution of a value that is equally likely within a specified range
#         Normal
#         Range: [−∞,∞
#         ]
#         Parameters: mean = central tendency; SD = standard deviation
#         Interpretation: Symmetric bell-shaped curve with unbounded tails
#         Gamma Γ
#         Range: [0,∞
#         ]
#         Parameters: shape, scale
#         Interpretation: mean=shape∗scale
#         , variance=shape∗scale2
#         ; generates a variety of shapes (including normal and exponential) for positive continuous variables
#         Beta β
#         Range: [0,1] (can be rescaled to any range by simple multiplication and addition)
#         Paramters: shape1, shape2
#         Interpretation: if shape1 and shape 2 are integers, interpret as a coin toss, with shape1 = # of successes + 1, shape2 = # of failures + 1. Gives distribution of value of p, estimated from data, which can range from exponential through uniform through normal (but all are bounded). Setting shape1 and shape2 <1 yields u-shaped distributions.
#           The “grammar” of probability distributions in R
#         d gives probability density function
#         p gives cumulative distribution function
#         q gives quantile function (the inverse of p)
#           r gives random number generation
#         Combine these with the base name of the function. For example rbinom gives a set of random values drawn from a binomial, whereas dnorm gives the density function for a normal distribution. There are many probability distributions available in R, but we will discuss only 7 of them.

### these were premade by Nick, thanks Nick!

############################
# Function: my_histo
# Purpose: creates a ggplot histogram
# Requires: ggplot
# Input: x = a numeric vector
#        data_type= "cont" or "disc"
# Output: a ggplot histogram
############################


library(ggplot2)
theme_set(theme_dark(base_size = 16))

my_histo <- function(x=NULL,data_type="cont") {
  if(is.null(x)) x=runif(1000)
  df <- data.frame(x=x)

  #there are three possible statements that can be used

  # 1.  if data are continuous bounded (0,1), adjust bins for histogram
  if (data_type=="cont" & min(df$x) > 0 & max(df$x) < 1) {
    p1 <- ggplot(data=df) +
      aes(x=x) +
      geom_histogram(boundary=0,
                     binwidth=1/30,
                     color="black",
                     fill="magenta") +
      scale_x_continuous(limits=c(0,1))}


  # 2.  if data are continuous, but not bounded (0,1), use
  # ggplot default bins
  if (data_type=="cont" & (min(df$x) < 0 | max(df$x) > 1)) {
    p1 <- ggplot(data=df) +
      aes(x=x) +
      geom_histogram(color="black",
                     fill="black")}


  # 3.  if data are discrete integers,
  #  use geom_bar to create a histogram becuase you can't use a histogram with anything non numeric
  if (data_type=="disc") {
    p1 <- ggplot(data=df) +
      aes(x=x) +
      geom_bar(color="black",fill="limegreen") }

  print(p1)
}

my_histo()
my_histo(data_type="disc",x=rpois(1000,lambda=0.2))
my_histo(data_type="cont",x=runif(1000))
my_histo(data_type="cont",x=rnorm(n=1000,mean=0,sd=1))


############################
# Function: my_pdf probability density function not the other thing
# Purpose: creates a ggplot probability density function
# Requires: ggplot
# Input: x = a numeric vector of x values
#        y = pdf values calculated for each value of x
#        data_type= "cont" or "disc"
# Output: a ggplot pdf
############################


my_pdf <- function(x=NULL,y=NULL,data_type="cont") {
  if(is.null(x) | is.null(y)) {
    x=seq(from=-3,to=3,length.out=100)
    y=dnorm(x) }

  df <- data.frame(x=x,y=y)

  # option number 1 for continuous distributions,
  # plot the line for the pdf
  if(data_type=="cont") {
    p1 <- ggplot(data=df) +
      aes(x=x,y=y) +
      geom_line() +
      geom_area(fill = "dodgerblue") }

  # option number 2 for discrete distributions,
  # plot a bar for the probability at each value
  if (data_type=="disc") {
    p1 <- ggplot(data=df) +
      aes(x=x,y=y) +
      geom_col(color="black",fill="chartreuse") } #apparently there is a difference between a geom_col and geom_bar?
  print(p1)
}

my_pdf()
my_x=seq(from=0,to=1,length.out=100)
my_pdf(x=my_x,y=dbeta(x=my_x,shape1=15,shape2=10))
my_pdf(x=0:10,y=dpois(x=0:10,lambda=1.1),data_type="disc")

################### Alright back to learning about Probability Distributions #############

####### Negative Binomial #############

# negative binomials are more about failures and seeing how long it take sto get successes

#-------------------------------------------------
# negative binomial: number of failures (values of MyVec)
# in a series of (Bernouli) with p=probability of success
# before a target number of successes (= size)
# generates a discrete distribution that is more
# heterogeneous ("overdispersed") than Poisson
hits <- 0:40
my_vec <- dnbinom(x=hits, size=5, prob=0.5) #size is number of trials and prob is odds of a success
my_pdf(x=hits,y=my_vec,data_type="disc")

# special case in that we do only one trial,

# geometric series is a special case where N= 1 success
# each bar is a constant fraction 1 - "prob" of the bar before it
my_vec <- dnbinom(x=hits, size=1, prob=0.1)
my_pdf(x=hits,y=my_vec,data_type="disc")


# alternatively specify mean = mu of distribution and size,
# the dispersion parameter (small is more dispersed)
# this gives us a poisson with a lambda value that varies
# the dispersion parameter is the shape parameter in the gamma
# as it increases, the distribution has a smaller variance
# just simulate it directly

#note that the negative binomial is a discrete distribution

nbi_ran <- rnbinom(n=1000,size=10,mu=5)
my_histo(x=nbi_ran,data_type="disc")

# the small the size parameter the larger the variance
nbi_ran <- rnbinom(n=1000,size=0.1,mu=5)
my_histo(x=nbi_ran,data_type="disc")


############ Uniform Distribution ###########

#-------------------------------------------------
# uniform
# params specify minimum and maximum

#runif for random data
my_histo(x=runif(n=100),data_type="cont")
my_histo(x=runif(n=1000),data_type="cont")

#-------------------------------------------------

############# Normal Distribution ############

# normal, note that normal will include values that are less than zero which for some real world applications is not possible
my_norm <- rnorm(n=100,mean=100,sd=2)
my_histo(x=my_norm,data_type="cont")


# problems with normal when mean is small but zero is not allowed.
my_norm <- rnorm(n=100,mean=2,sd=2)
my_histo(x=my_norm,data_type="cont")

summary(my_norm)
toss_zeroes <- my_norm[my_norm>0]
my_histo(x=toss_zeroes,data_type="cont")

summary(toss_zeroes)


################## Gamma Distribution ################

#-------------------------------------------------
# gamma distribution, continuous positive values, but bounded at 0

my_gamma <- rgamma(n=100,shape=1,scale=10)
my_histo(x=my_gamma,data_type="cont")

# gamma with shape= 1 is an exponential with scale = mean

# shape <=1 gives a mode near zero; very small shape rounds to zero
my_gamma <- rgamma(n=100,shape=0.1,scale=1)
my_histo(x=my_gamma,data_type="cont")

# large shape parameters moves towards a normal
my_gamma <- rgamma(n=100,shape=20,scale=1)
my_histo(x=my_gamma,data_type="cont")

# scale parameter changes mean- and the variance!
my_histo(x=rgamma(n=100,shape=2,scale=100),data_type="cont")
my_histo(x=rgamma(n=100,shape=2,scale=10),data_type="cont")
my_histo(x=rgamma(n=100,shape=2,scale=1),data_type="cont")
my_histo(x=rgamma(n=100,shape=2,scale=0.1),data_type="cont")

############# Beta distribution #############

## what a beta distribution does is figure out how a distribution would be at small samples sizes given that it is usually better at large values. The way it does this is by figuring out a "prior distribution" aka a guess. An educated guess but still a guess.

#-------------------------------------------------

# beta distribution
# bounded at 0 and 1
# analagous to a binomial, but result is a continuous distribution of probabilities
# parameter shape1 = number of successes + 1
# parameter shape2 = number of failures + 1
# interpret these in terms of a coin you are tossing

# shape1 = 1, shape2 = 1 = "no data"
my_beta <- rbeta(n=1000,shape1=1,shape2=1)
my_histo(x=my_beta,data_type="cont")


#essentially what this is doing is showing how the distribution gets better with the more data that represents the outcomes. More data is always better


# shape1 = 2, shape1 = 1 = "1 coin toss, comes up heads!"
my_beta <- rbeta(n=1000,shape1=2,shape2=1)
my_histo(x=my_beta,data_type="cont")
# two tosses, 1 head and 1 tail
my_beta <- rbeta(n=1000,shape1=2,shape2=2)
my_histo(x=my_beta,data_type="cont")
# two tosses, both heads
my_beta <- rbeta(n=1000,shape1=2,shape2=1)
my_histo(x=my_beta,data_type="cont")
# let's get more data, remember that we should be getting closer to .50 for coins since that is the true probability
my_beta <- rbeta(n=1000,shape1=20,shape2=20)
my_histo(x=my_beta,data_type="cont")
my_beta <- rbeta(n=1000,shape1=500,shape2=500)
my_histo(x=my_beta,data_type="cont")

# if the coin is biased
my_beta <- rbeta(n=1000,shape1=1000,shape2=500)
my_histo(x=my_beta,data_type="cont")
my_beta <- rbeta(n=1000,shape1=10,shape2=5)
my_histo(x=my_beta,data_type="cont")


# shape parameters less than 1.0 give us a u-shaped distribution
my_beta <- rbeta(n=1000,shape1=0.1,shape2=0.1)
my_histo(x=my_beta,data_type="cont")



############### Estimate Parameters ################

# the idea is that we have some data in hand and we want to know the parameters that might have caused it.

library(MASS)
data <- c(100,100,104,99)
z <- fitdistr(data,"normal")
print(z)
my_beta <- rbeta(n=1000,shape1=0.5,shape2=0.2)
my_histo(x=my_beta,data_type="cont")


######## Example data

# I believe the frog data are from snout measurements

frog_data <- c(30.15,26.3,27.5,22.9,27.8,26.2)

# get and print model parameters assuming a normal distribution
z<- fitdistr(frog_data,"normal")
print(z)

# plot the density function for the normal and annotate the plot with the original data
x <- 1:100
g_density <- dnorm(x=x,mean=z$estimate["mean"],sd=z$estimate["sd"])
qplot(x,g_density,geom="line") + annotate(geom="point",x=frog_data,y=0.001)

#the plot shows where the bulk of the data *should be* and then the points show that the estimate matches reality

# now do the same for a gamma distribution, which has a shape and rate parameter as outputs from fitdistr
z<- fitdistr(frog_data,"gamma")
print(z)

# plot the density function for the gamma and annotate the plot with the original data
x <- 1:100
g_density <- dgamma(x=x,shape=z$estimate["shape"],rate=z$estimate["rate"])
qplot(x,g_density,geom="line") + annotate(geom="point",x=frog_data,y=0.001,color="red")

# similarly this shows the distribution and compares it to the reality the only difference is that we are using the g-density

# but what if we add in some outliers? hehehehehhehehehehhehehhehehehehehe

frog_data <- c(30.15,26.3,27.5,22.9,27.8,26.2)
outlier <- 0.050 #the sneaky lil outlier muhaha
frog_data <- c(frog_data,outlier)

# get and print model parameters assuming a normal distribution
z<- fitdistr(frog_data,"normal")
print(z)

# plot the density function for the normal and annotate the plot with the original data
x <- 1:100
g_density <- dnorm(x=x,mean=z$estimate["mean"],sd=z$estimate["sd"])
qplot(x,g_density,geom="line") + annotate(geom="point",x=frog_data,y=0.001)

#oooo look at that, it forks the distribution up by quite a bit

# now do the same for a gamma distribution, which has a shape and rate parameter as outputs from fitdistr
z<- fitdistr(frog_data,"gamma")
print(z)

# plot the density function for the gamma and annotate the plot with the original data
x <- 1:100
g_density <- dgamma(x=x,shape=z$estimate["shape"],rate=z$estimate["rate"])
qplot(x,g_density,geom="line") + annotate(geom="point",x=frog_data,y=0.001,color="red")

# oh it really messes up the gamma distribution and changes the entire shape.


