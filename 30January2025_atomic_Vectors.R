# more properties of atomic vectors
# 30 January 2025
# RMJ


################## 30 January 2025 ##################

# create an empty vector, specify mode and length

z <- vector(mode='numeric', length = 0)

print(z)

# we cna load values into the vector

z <- c(z,5)

print(z)

#this is not a very efficient process, the dynamic sizing is very slow

# has 100 0s in a numeric vector. the rep takes the value in the first part, and how many in the second part

z <- rep(0,100)

head(z)

# alternatively we could fill it with NAs

z <- rep(NA,100)

#this is probably not a good idea since NA doesn't really have a useful type.

typeof(z)

#says it is logical which may not be what we want

z[1] <- "Arizona"
typeof(z)

#interesting, so with that one assignment this changes the type to character

typeof(z[2])

#even when we select a cell that isn't actually a character

######################

#makes 100 random integers

my_vector <- runif(100)

#this will paste the word 'species' followed by a number sequentially counting up to the length of the vector (which is 100) separated by nothing but we could do anything we wanted

my_names <- paste("Species",seq(1:length(my_vector)),sep = "")

#this will make the column headers the names
names(my_vector) <- my_names
head(my_vector)
str(my_vector)


##############################

#rep has a lot of useful functions

rep(0.5,6) #just repeats

#you can also write it
rep(x=0.5,times=6)

#if we use the names then the order is irrelevant

rep(times=6,x=0.5)

my_vec <- c(1,2,3)

rep(x=my_vec,times=2) #will repeat the entire vector 'my_vec' twice

rep(x=my_vec,each=2) #will repeat each element in the vector twice

rep(x=my_vec,times=my_vec) # in this case its going to use the values in my_vec to decide how many times, so the firs telement 1 time, the second element 2 times, the third element 3 times

rep(x=my_vec,each=my_vec) #this only half works, because the 'each' statement is looking for a single number. It just grabs the first number

#########################

#now let's check out the seq argument

seq(from=2,to=4)

#which is the same as

2:4

#we can also count by a specific number

seq(from=1,to=5,by=.5)

#this will automatically figure out how to divide it up to fit the stated length

x <- seq(from=1,to=10,length=7)

#this is another method but its sloooowwww

my_vec <- 1:length(x)

#this is much faster

seq_along(my_vec)

#as is this

seq_len(5)

###########################

#lets talk about random number generators

#rnorm gives random normal and runif gives random uniform

runif(5)

runif(n=3,min=100,max=156)

#normal values meaning they have a mean of 0 and an STD of 1

rnorm(6)

#but we can set it so that the mean and std are specific

x <- rnorm(n=1000,mean=100,sd=30)

hist(x)

#But remember if we decrease the n you may not actually get representative values

###################

#lets do some stuff in ggplot

library(ggplot2)

theme_set(theme_bw(base_size = 14))

z <- runif(1000)

#the qplot function will bring up a quantitative plot

qplot(x=z)

z <- rnorm(10000)

qplot(x=z)

#######################

#what if we wanted to just sample from our dataset?

long_vec <- seq_len(10)
typeof(long_vec)
str(long_vec)

#basics

sample(x=long_vec)

# we can be specific if we want a certain number

sample(x=long_vec,size = 5) #note that this is defaulted, sampling without replacement

#but we CAN replace

sample(long_vec,size = 10,replace = TRUE)

#What if we wanted to stack the deck and make some values more likely
my_weights <- c(rep(20,5),rep(100,5))

sample(x=long_vec,replace = TRUE,prob = my_weights)

#basically this biases it to the higher values because the 100s are towards the end

#the probability becomes irrelevant if you sample without replacement

sample(x=long_vec,replace = FALSE,prob = my_weights)

#What does this do though?

sample(x=long_vec,replace = TRUE,prob = long_vec) #well technically each number should have increased probability the further you go up

###############

#subsetting! Slice and dice baby!

z <- c(3.1,9.2,1.3,0.4,7.5)

#this will grab the second and third element

z[c(2,3)]

#Check this out. We can put a negative and then get everything EXCEPT what is listed

z[-c(2,3)]

#we can also create a vector of logical elements to select conditions

z[z<3] #will return everything that is TRUE

#just z<3 gives logical returns

z<3

#the which function will tell you WHERE the true values are

which(z<3)

#so not the actual values but where they are

z[which(z<3)] #this also works but is kinda superfulous

#can also use length() for relative positioning to last element. this will give the first two elements

z[-(length(z):(length(z)-2))]

######################################


################## 4 February 2025 ##################


z <- c(3.1,9.2,0.4,7.5,6.6)

#there is a letters vector that will let you just grab alpha letter
names(z) <- letters[1:5]

#and now we can subset using the names as opposed to the position number

z[c("b","c")]

########## Operators used with vectors

# inequality and comparison operators

# <, >, ==, >=, <=

# logicals

# ! = not
# & and (vector)
# | #or (vector)
# xor (x,y) note that one of them has to be true

x <- 1:5
y <- c(1:3,7,7)

#we can make logical questions and get boolean responses

x == 2
x != 2

#compound statements

x == 1 & y == 7

#this will line up the vectors from left to right basically ask if there is an alignment where this is true

#there is not

#however if we do OR instead that chnages

x == 1 | y == 7

#nice, some of these are TRUE

x == 3 | y == 3

#xor instead

xor(x==3,y==3)

#this does not give us a true value. this is because xor is a 'one or the other' rule. it CANNOT have both be true.

z2 <- 5

#for the statement

z2 == 4 | 6

# the answer should be false but it isn't because it is not a full statement
#this is a full statement

z2 == 4 | z2 == 6

############ subsetting

#set the random seed

z <- runif(10)

print(z)


set.seed(626)

z < 0.5 # create a logical vector

#this will actually pull out the values that are TRUE

z[z<0.5]

# but this will remove the values that don't match. if we want the positions though

which(z<0.5)

#and this give an identical result
z[which(z<0.5)]

#this won't work with missing values


