# Control Structures
# 13 February 2025
# RMJ


# simple inequalities

5 > 3
5 < 3
5 >= 5
5 <=5
5==3
5!=3

# when we use and statements we are looking for situations where both sides are true

FALSE & FALSE #eventhough they are both FALSE we are specifically looking for TRUE and TRUE statements. for And to work, both sides MUST be TRUE

FALSE & TRUE
TRUE & TRUE

5 >3 & 1!=2
 1==2 & 1!=2 #a true and false

 #OR functions can be tricky

 FALSE | TRUE
 FALSE | FALSE
 TRUE | TRUE

 #this works the same with vectors HOWEVER, it is going to do it one vector at a time so we can get a whole list of trues and falses

 #so this will make a comparison to each number in sequence and compare them to 3 so we get 5 logical returns

 1:5 > 3

 #these two vectors contain the same elements but the order is different

 a <- 1:10
 b <- 10:1

 #so this will return logics for eahc comparison, there will only be a few where it is true for both

 a > 4 & b > 4

 #there is also xor which wants want statement to be false and one to be true

 xor(FALSE,FALSE)
 xor(FALSE,TRUE)
 xor(TRUE,TRUE)
 a <- c(0,0,1)
 b <- c(0,1,1)

 xor(a,b)

 a|b

####################### Set Operations ####################

 # boolean algebra on sets of atomic vectors (logical, numerical, character)

 a <- 1:7
 b <- 5:10

 #union grabs all the UNIQUE elements

 union(a,b)

 #whereas concatenate just smushes them together
 c(a,b)

 # but the unique function could get past this

 unique(c(a,b))

 #intersect will get all the common elements between values, its like asking what is duplicated

 intersect(a,b)

 # setdiff to get distinctive elements in variables

 #found in a not in b
 setdiff(a,b)

 #found in b not in a
 setdiff(b,a)

 #are they equal?

 setequal(a,b)

 z <- matrix(1:12,nrow = 4,byrow = TRUE)
z1 <- matrix(1:12,nrow = 4,byrow = FALSE)

#this just compares element by element
z==z1

#use identical for entire structures

identical(z,z1)

z1 <- z

identical(z1,z)

d <- 12

#can you find this value within these other values

d %in% union(a,b)

d <- 4

d %in% union(a,b)

#and you can check for multiple elements

d <- c(10,12)
d %in% union(a,b)
d %in% a




################### IF Statements #########################

#three scenarios

if (condition) {expression1} #must generate a single logical values

if (condition) {expression1} else {expression2}

if (condition1) {expression1} else
  if (condition2) {expression2} else
