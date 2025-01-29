#Introduction to R scripts
# 28 January
# RMJ

# using the assignment operator

x <- 6

y = 4 # also works but the <- is preferred

y <- y +1.1


# variables should begin with a lower case letter

z <-3
plantHeight <- 10 # this is camelcase formatting
plant.height <- 4.2 # avoid periods if you can
plant_height <- 3.3 # is optimal and is called snake case. lowercase with dash

. <- 5.5 # use as a generic temporary variable

#Are the data homogenous? or are all the elements of the same type, or are they heterogenous?
# Are they one dimensional or two dimensional

# Homo 1D: atomic vector
# Homo 2D: matrix
# Hetero 1D: List
# Hetero 2D: Dataframe (list of equal length vectors)
#the multidimensional version is an array

#Types of Atomic Vectors
# Character strings
# integers
# doubles (rational numbers with a decimal point)
# logical
# factor
# vector of lists

# the combine function

r <- c(3.2, 5,6,7)

print(r)

typeof(r)
is.numeric(r)

#you can have functions within functions

r <- c(c(8,8.5),c(4,5,6,19,0,1))

u <- c("lion","witch","ogre")

print(u)

typeof(u)

z <- c("this is only 'one' character string", 'a second')

print(z)

# and the logicals

x <- c(TRUE,FALSE,FALSE)

print(x)

typeof(x)

is.logical(x)

# the 'as' function can coerce things into specific variables

x <- as.character(x)

# we can also check the length
#the length is the number of elements within that variable

length(x)

# we can add names after a variable is created

z <- runif(6,min = 0,max=100)

names(z) <- c("Grape","Orange","Strawberry","Cherry","Blue Coconut","Black Raspberry")

print(z)

#this is how we grab specific vectors, for example the 2nd vector and its name


print(z[2])

#using the name would also work

print(z["Orange"])

z2 <- c(gold=3.3,silver=89,lead=23)

z2

#reset the names

names(z2) <- NULL

# and give them new ones

names(z2) <- c("copper","zinc")
print(z2)

# NA values for missing data

z <- c(3.2,2.56,NA)

typeof(z)
length(z)


#there is more than one type of NA

is.na(z)
mean(z)


#other errors
#NaN =not a number
z <- 0/0
print(z)

z <- 1/0 #Inf
z <-  -1/0 # -Inf



#notable features of atomic vectors
#coercion. Get'em

#all atomics are of the same type
#if they are different, R coerces them
# logical -> integer -> double -> character

a <- c(2, 2.0)

print(a)
typeof(a)
b <- c("purple","green")

typeof(b)

d <- c(a,b)

typeof(d)

a <- runif(10)

print(a)

#comparison operators yield a logical result

a > .05

#but we can count them

sum(a>.5)

#because the logic is outranked by the numeric they will be coerced into numbers and then counted

mean(a>.5)

. <- a > .5
print(.)
. <- as.integer(.)
print(.)
print(sum(.))

mean(rnorm(10000) >2)

# when you try to add something to a vector it will try to do it to everything in the vector

z <- c(10,20,30)
z+1

y <- c(1,2,4)

z+y

z <- c(10,20,30)
x <- c(1,2)

z+x
