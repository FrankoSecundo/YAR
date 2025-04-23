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

  list <- list.files(".",pattern = "\\d.csv$")
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

  combined.df.clean <- combined.df[,c(14,16,27)]
  combined.df.clean$count <- paste(as.numeric(1))

  cmdf <- combined.df.clean %>% group_by(year)
  cmdf <- cmdf %>% filter(scientificName!="")
  cmdf$count <- as.numeric(cmdf$count)
  cmdf.sum <- cmdf %>% summarise(year_count=sum(count))

  p1 <- ggplot(data = cmdf.sum)+geom_bar(aes(x=year,y=year_count,fill=year),stat = "identity")+ylab("Bird Count")+theme_bw(base_size = 16)

  write.csv(cmdf,file = "cmdf.csv",row.names = FALSE)
  write.csv(cmdf.sum,file = "abundance.csv",row.names = FALSE)

  return(p1)

} # end of function calculate_abundance
# --------------------------------------
# calculate_abundance()



current.files<- list.files(".")
countdata <- current.files[3]
