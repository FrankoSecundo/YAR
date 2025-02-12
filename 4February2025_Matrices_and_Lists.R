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


########################## 6 February ####################


# adding a new row it has to come in as a list

new_data <- list(var_a=13,var_b="Bottom",var_c=runif(1))

print(new_data)
str(new_data)

#using rbind (old data frame, new dataframe)

d_frame <- rbind(d_frame,new_data)
str(d_frame)
#and we can check the new row
tail(d_frame)


#But what if you want to add a new column?
#too bad

#bitch

#make a new variable

new_var <- runif(13) #note this matches the number of rows
d_frame <- cbind(d_frame,new_var)

#note that it will automatically take the object name as the column name
head(d_frame)


# we are going to create a new matrix to play with

z_mat <- matrix(data = 1:30,ncol = 3,byrow = TRUE)
z_dframe <- as.data.frame(z_mat) #this will smush the matrix into the dataframe

str(z_mat)
str(z_dframe)

head(z_dframe)
head(z_mat)

#note that the column names are auto assigned in the dataframe

#if we wanted to grab a specific element the syntax between matrix and dataframe are the same

z_mat[3,3]
z_dframe[3,3]

z_mat[,3] #this means ignore the row grab the entire column
z_dframe[,3]

z_mat[3,] #ignore the column grab the entire row
z_dframe[3,]

z_mat[2] #will grab the second element of the atomic vector (going from top to bottom)
z_dframe[2] #this will assume you meant the second variable aka the second column

z_dframe["V2"]
z_dframe$V2


################ Eliminating NAs

zd <- runif(14)
#add in random NAs
zd[c(1,5,8)] <- NA

print(zd)

#this function complete_cases will do a boolean assessment on whether each spot is a number or not. TRUE=is number FALSE=is not number
complete.cases(zd)
zd[complete.cases(zd)]

which(!complete.cases(zd)) #this finds the positions of FALSE note that with the ! it means NOT true

#now lets tackle a matirx with missing values

m <- matrix(1:20,nrow=5)
#contaminate it with Nas

m[1,1] <- NA
m[5,4] <- NA
m[2,3] <- NA

m[complete.cases(m),]

m[complete.cases(m[,c(1,2)]),] # drops row 1

#lets make a new matrix

m <-  matrix(data = 1:12,nrow=3)

#the first part will create the row labels, the second part will create the column labels
dimnames(m) <- list(paste("Boyos",LETTERS[1:nrow(m)],sep = ""),paste("Site",1:ncol(m),sep = ""))
print(m)

#we can also subset the matrix based on the elements

#behold!
#grab row 1 and 2 and column 3 and 4
m[1:2,3:4]
#the equivalent would be
m[c("BoyosA","BoyosB"),c("Site3","Site4")]

m[1:2,]

m[,3:4]

#first try a logical that can be applied to all columns

colSums(m)>15

#returns a boolean statement for each column
#but this will grab the data itself

m[,colSums(m)>15]

m[rowSums(m)==22,]

#flip it and reverse it

m[rowSums(m)!=22,]


#e.g. choose all rows for which the numbers for site 1 are less than 3 AND choose all columns for which the numbers for species A are less than 5 (boyos)

#first try this logical for rows

m[,"Site1"]<3
m[m[,"Site1"]<3,]

m["BoyosA",]<5

#add this in and select with all rows

m[,m["BoyosA",]<5]

m[m[,"Site1"]<3,m["BoyosA",]<5]

##caution, simple subscripting to a vector changes the data type!

z <- m[1,]
print(z)
str(z)

z2 <- m[1, ,drop=FALSE]
print(z)
str(z)


#we will bring in a dataset

data <- read.csv(file = "antcountydata.csv",header = TRUE,sep = ",")
ant <- data

unique(data$state)

library(ggplot2)

theme_set(theme_bw(base_size = 16))

ggplot(data = ant)+geom_bar(aes(state,n.species,fill=state),stat = 'identity')

?geom_bar
