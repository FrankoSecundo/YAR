# Matrices, List, Dataframes
# 11 February 2025
# RMJ

###################### Importing Data ######################

#we will do a little experiment with importing csv files

td <- read.csv("Toydata.csv",sep = ",")

#thats no good it looks like it interpreted some of the lines poorly, lets do readtable

td <- read.table(file = "Toydata.csv",header=TRUE,sep = ",",comment.char = "#")

#this is better because it also allows us to denote comment lines that are not part of our data

#lets do a little inspection

str(td)

#a good point to note is that it did acknowledge the NA like we asked

#if we wanted to add a column we could do it like so

td$newvar <- runif(4)

head(td)

#we could also do cbind if we wanted

# once we have everything modified in the way we like we can then write it back to disc

write.table(x=td, file = "toydata_edits.csv",sep = ",") # note that this works HOWEVER it will erase the comments from the document.

#INSTEAD of saving individual csvs it makes more sense to save as an RDS. which is an R specific format

saveRDS(td,file = "td.RDS") # .RDS is not strictly necessary BUT it is good practice

#and of course what is written must be read

restored_td <- readRDS("td.RDS")

#and SHELAKAZEE it has been restored!



