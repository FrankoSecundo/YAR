# --------------------------------------
# FUNCTION calculate_abundance
# required packages: none
# description:
# inputs:
# outputs:
########################################
calculate_abundance <- function(){

# build a dataframe that has all the values in it

setwd(dir = "CleanedData/")

  list <- list.files(".")
  pr <- read.csv(file = list[1],header = TRUE,sep = ",")

  df <- data.frame(matrix(nrow=0,ncol=length(pr)))

  colnames(df) <- colnames(pr)

  for(i in list){
    i.df <- read.csv(file = i,header = TRUE,sep = ",")
    df <- rbind(df,i.df)

  }

  combined.df <- df
  write.csv(df,file = "countdata.allyears.csv",row.names = FALSE)

  # add a column for year

  combined.df <- combined.df %>% mutate(year=substring(startDate,1,4))


  return(print('...checking function: calculate_abundance()'))
  return(print('function complete, high five!'))

} # end of function calculate_abundance
# --------------------------------------
# calculate_abundance()



current.files<- list.files(".")
countdata <- current.files[3]
