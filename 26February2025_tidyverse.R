# Tidyverse!
# 26 February 2025
# RMJ

# dplyr
# tidyr
# stringr

#SQL is a structured query language. used to interact with rletional databases

#can be used to query the dataset search for patterns, and create new rows/calculations

#in R there is the sqldf package


##################### dplyr ########################

library(tidyverse)

# dplyr is for data manipulation and structuring the dataset. super useful

# the core commands are

# filter()
# arrange()
# select()
# summarize() and groupby()
# mutate()

#to load in a default dataset you do

data() #and you can select from the list

sw <- data(starwars)

sw <- starwars

class(sw)

#this is a tibble which is generlaly more efficient. tibbles do less as a tradeoff to make code simpler and less prone to crashing

glimpse(sw) #glimpse is like head or str() but a bit more readable and shows more data to allow you to get a glimpse

#lets clean this bitch

# note that base R has the compleete.cases function which removes any row with an NA

#ex

sw.clean <- starwars[complete.cases(starwars[,1:10]),] #check the first 10 columns for NAs and remove them

#you can check for NAs

is.na(sw.clean[,1])

anyNA(sw.clean[,1:10])

############# filter ################

# filter function this will pick or subset observations by their values

#this operates on logical operators < > == != & |

# filter automatically excludes NAs, have to ask for them specifically

filter(sw.clean, gender=="masculine" & height < 180) # note that you can use a comma and the & interchangably! NEW KNOWLEDGE!

filter(sw, gender=="masculine", height<180, height >100)

# we cna also use in

filter(sw, eye_color %in% c("blue","brown"))


##### Arrange reorders the rows #############

arrange(sw.clean, by=height) # default ascending

arrange(sw.clean, by=desc(height))

#we can also account for ties

arrange(sw.clean,by=desc(height), desc(mass))

sw1 <- arrange(sw, by=height)

#check to see if it did it

tail(sw1)

# note that its all NAs

### Select can choose variables by their names

# can be done in base r

sw.clean[1:10,]

select(sw.clean, 1:10) #grabs the first 10 columns

select(sw.clean,name:species) # can be done if you know the column names

# can use the minus sign to exclude

select(sw.clean,-(films:starships))


# rearrange the columns

select(sw.clean, homeworld, name, gender, species, everything())# note that everything will just dump whatever is left

select(sw.clean,contains("color")) #give me every column that has the string color

# other helpers include: ends_with, starts_with, matches, num_range

#rename columns!

select(sw.clean,haircolor=hair_color) # note that its old on the left and new on the right

# or you could just use the rename function. what a waste

rename(sw.clean, haircolor=hair_color)


########## mutate ##############

# mutate creates new variables from old variables

mutate(sw.clean,ratio=(height/mass))

sw.lbs <- mutate(sw.clean,mass_lbs=mass*2.2) #convert from kg to lbs

sw.lbs <- select(sw.lbs, 1:3, mass_lbs,everything())

# if you ONLY wanted the new variable and nothing else, you'd use transmute

transmute(sw.clean,mass_lbs=mass*2.2)

########### summarize and groupby ###############

# this is used to collapse rows and values down to a summary

# summarize by its own isn't very useful, the groupby gives you control

summarize(sw.clean, meanHeight=mean(height)) #this summarizes the entire table

# we can run it without nas

summarize(sw, meanHeight=mean(height, na.rm=TRUE),TotalNumber=n()) # and this also counts how many entries

# use groupby for additional functionality

sw.gender <- group_by(sw,gender)

head(sw.gender) # now shows that there are groups

summarize(sw.gender, meanHeight=mean(height, na.rm=TRUE))


################### Piping ##################

# you can pass intermediate results to the next command

# pipe %>% stands for 'and then'

sw.clean %>% group_by(gender) %>% summarize(meanHeight=mean(height, na.rm=T), number=n())


############ case_when() ##############


#is useful like an ifelse statemtn

sw.clean %>% mutate(sp=case_when(species=="Human" ~ "Human", TRUE ~ "Non-Human")) %>% select(name, sp,everything())


########## Long to wide format #################


#make dataset wider

widesw <- sw.clean %>% select(name, sex,height) %>% pivot_wider(names_from = sex, values_from = height,values_fill = NA)

# thats not very obvious lets try a bigger example

pivotsw <- starwars %>% select(name, homeworld) %>% group_by(homeworld) %>% mutate(rn=row_number()) %>% ungroup() %>% pivot_wider(names_from = homeworld,values_from = name)


#we can make the dataset LOOOOOOoooooooooooooooooooooonger to

widesw %>% pivot_longer(cols = male:female,names_to = "sex",values_to = "height",values_drop_na = TRUE)


