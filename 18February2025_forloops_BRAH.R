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

