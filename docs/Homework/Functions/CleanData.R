# --------------------------------------
# FUNCTION clean_data
# required packages: none
# description:
# inputs:
# outputs:
########################################
clean_data <- function(){

  for(i in c.file.l){

    r.file <- read.csv(i,header = TRUE,sep = ",")
    r.file.clean <-r.file[complete.cases(r.file$scientificName), ]

    new.name <- str_replace(i,"Ori.*brd_","")
    new.name <- str_replace(new.name,".expanded.*","")

    clean.f <- paste("CleanedData/",new.name,".csv",sep = "")

    write.csv(r.file.clean,file = clean.f,row.names = FALSE)


  }

return(print('...checking function: clean_data()'))

  return(print("Please check the Cleaned Data folder to see the csv files with missing values omitted"))

} # end of function clean_data
# --------------------------------------
# clean_data()
