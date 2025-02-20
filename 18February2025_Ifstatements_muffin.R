# If Statements
# 18 February 2025
# RMJ

# these are conditional statements, when TRUE a certain section will run and when it is false a separate (usually shorter) condition will run

z <- signif(runif(1),digits = 2)
print(z)

z > 0.5

if (z > 0.5) cat(z, "is a bigger than average number","\n")


#####

if ( z> .8) {cat(z, "is a large number","\n")} else
  if(z<.2) {cat(z,"is a small nnumber","\n")} else
  {cat(z,"is a number of typical size","\n")
    cat("z^2 = ",z^2,"\n")}


#####

tester <- runif(1000) # start with a random uniform dis

# elements, ifelse(condition, true statment output, false statement output)

eggs <- ifelse(tester > 0.35,rpois(n=1000,lambda=10.2),0)

hist(eggs)

#this is strongly determined by the lambda

#######

#we'll create an if else that also allows us to label the value under a category

pVals <- runif(1000)
z <- ifelse(pVals <= 0.025,"lowerTail","nonSig")
z[pVals>=0.975] <- "upperTail"
#this fun table function does a quick summary of each unique thing and sums them up
table(z)

# thats all well and good but we can be more efficient without doing an ifelse statement

z1 <- rep("nonsig",length(pVals))
z1[pVals<=0.025] <- "lowerTail"
z1[pVals>=0.975] <- "upperTail"
table(z1)



