# dplyr and SQL
# 27 February 2025
# RMJ


# bring the sql package as well as tidyverse

library(sqldf)
library(tidyverse)


sp.cl <- read.csv("Datasets/site_by_species.csv")
vr.cl <- read.csv("Datasets/site_by_variables.csv")

# take a peek

head(sp.cl)

# kinda ugo, each row is a site and then each column apart from the long and lat is the species. note that this is presence absence so only zero or one

head(vr.cl)

#these are site variables

glimpse(vr.cl)


# start with using operations/functions on just 1 file, subseting rows

################ dplyr method for subsetting rows #################


sp <- filter(sp.cl,Site<30)

vr <- filter(vr.cl,Site<30)


################### SQL method for subsetting rows ################

# SQL operates on a few keywords. you need to create a query statement

# here we are selecting 3 species, FROM the sp table, under the condition (where) site is less than 30

query="SELECT Site, Sp1, Sp2, Sp3 FROM sp WHERE Site<'30'"

# and we can launch direct from the the sqldf function note that we could have just put in the query string

sp.sql.1 <- sqldf(query)

########## Method for subsetting columns in dplyr ################

edit.sp <- sp %>% select(Site, Sp1, Sp2, Sp3)

# you can also use column number

edit.sp <- sp %>% select(1,2,3,4)

################### subsetting columns in SQL ##################

query="SELECT * FROM sp" #the * means everything

sp.sql.2 <- sqldf(query)

#we can also move the columns around when we select as an example

query="SELECT Site, Sp2, Sp1, Sp3 FROM sp WHERE Site<'30'"


######### rename columns dplyr ##############

sp <- rename(sp, Long=Longitude.x.,Lat=Latitude.y.)

# pull out all the numeric columns

sp.num <- sp %>% mutate(letters=rep(letters,length.out=length(sp$Site)))

sp.num <- select(sp.num, Site, Long, Lat, Sp1, letters)

sp.num.e <- select(sp.num, where(is.numeric))


## pivot longer lengthen data, decrease the number of columns and increase the number of rows

sp.long <- pivot_longer(edit.sp, cols = c("Sp1","Sp2","Sp3"), names_to = "ID")

sp.wide <- pivot_wider((sp))

#Aggregating the data, getting some kind of calculation

# SQL

query="SELECT SUM(Sp1+Sp2+Sp3) FROM sp.long GROUP BY SITE"

sqldf(query)

# you can aslo add a column

query="ALTER TABLE sp.long ADD new_column VARCHAR"


########## 2 file operations ###################

# joining datasets together which is different than bind fool
# in order to join there has to be at least one column that is the same between the two

#Left/Right/Union join this is the direction we are joining the dataset

# first start with clean files. cleant the species and var

edit.sp <- sp.cl %>% filter(Site<30) %>% select(Site, Sp1, Sp2, Sp3, Sp4, Longitude.x., Latitude.y.)

edit.vr <- vr.cl %>% filter(Site<30) %>% select(Site, Longitude.x.,Latitude.y.,BIO1_Annual_mean_temperature,BIO12_Annual_precipitation)


# Left_Join joining basically means we are stitching the matching rows of the seocnd file to the first. requires a matching/marker column to link the two datasets

left <- left_join(edit.sp,edit.vr,by = "Site")

right <- right_join(edit.sp,edit.vr,by="Site")

# inner join retains the rows that match between both files. so you can lose information

inner <- inner_join(edit.sp, edit.vr,by="Site")

# full join this will take all the values and all the rows and smashing it all together and puts NAs where it can't find matches

full <- full_join(edit.sp,edit.vr,by="Site")

############# SQL method for joining ############

query="SELECT BIO1_Annual_mean_temperature, BIO12_Annual_precipitation FROM edit.vr LEFT JOIN edit.sp ON edit.vr.Site = edit.sp.Site"


x <- sqldf(query)
