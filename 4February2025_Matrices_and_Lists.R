# Matrices and Lists
# 4 February 2025
# RMJ

# a matrix in an atomic vector that is organized into rows and columns

my_vec<- 1:12
#Inputs to vector: data (expects an atomic vector) then set dimensions (4 rows)
#can tell it number of columns

m<- matrix(data=my_vec,nrow=4)
print(m)

m<- matrix(data=my_vec, ncol=3)
print(m)

m<- matrix(data=my_vec, nco=3, byrow=TRUE)   #fills in by row not column
print(m)


#a list has a string of numbers, a matrix, letters, and pi
my_list <- list(1:10,matrix(1:8,nrow = 4,byrow = TRUE),letters[1:3],pi)

#what is the structure of the list?
str(my_list)

print(my_list)

#but what do those double brackets mean?

# using [] gives you a single item, which is of a type of list

my_list[4]

#but this won't work

my_list[4]-3

#whoopsie. when a single bracket is applied to a list it just gives that datapoint but doesn't change it to a number, it keeps it as a list

#double brackets will grab th eobject itself

my_list[[4]]

my_list[[4]]-3

#if a loist has 10 elements it is liek a train with 10 cars, double bracket will get you the contents and single brackets will get a another smaller train

my_list[[2]]

#what will this do?

my_list[[2]][4,1]

#oh ho! So we can do combinations with double and single. this is because we have pulled this list item out

#Lists can have names. Lets give these lil guys names


my_list2 <- list(tester=FALSE,lil_m=matrix(1:12,nrow=3))

#we can grab named objects in the list with money $$


my_list2$lil_m[2,4]

#and you don't even have to use double brackets. noice

#this gets you the whole damn thing

my_list2$lil_m

my_list2$lil_m[2,] #this gets you ALL THE COLUMNS! GIVE THEM TO ME! plz for row 2.

my_list2$lil_m[,2] #this will get you all the rows for the second column but written horizontally

#if you give it just a number...what does it give you in return?
my_list2$lil_m[2]
#long story short its going to just grab the second vector

#hey kid, wanna learn how to unlist a list?

unrolled <- unlist(my_list2)
print(unrolled)

#oh....is that what that does. it breaks everything out into its own little object

#lets make a better example

library(ggplot2)

y_var <- runif(1000)
x_var <- runif(1000)

my_model <- lm(y_var~x_var)

qplot(x=x_var,y=y_var)

print(my_model)

print(summary(my_model))

ggplot()

#how do we get what we want? WHAT WE DESERVE!?!?!

#so whats going on in this summary?

str(summary(my_model))

#whoa thats messy, well there is something that stands out, coefficients

#with the square brackets we can select

summary(my_model)$coefficients[2,4]

#but thats tricky instead lets unlist it

u <- unlist(my_model)

my_slope <- u$`coefficients.(Intercept)`
my_pval <- u$coefficients.x_var




################# Data Frames #################


#dataframes are just three lists in a top hat and moustache

#lets build a dataframe

var_a <- 1:12
var_b <- rep(c("Bottom","Top","Vers","PBottom"),each=3)
var_c <- runif(12)

#and this will stitch the different vectors together into an order

d_frame <- data.frame(var_a,var_b,var_c)

print(d_frame)
str(d_frame)
