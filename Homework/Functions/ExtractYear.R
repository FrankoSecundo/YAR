# --------------------------------------
# FUNCTION extract_year
# required packages: none
# description:
# inputs:
# outputs:
########################################
extract_year <- function(){

cl.names <- list.files("CleanedData/")
y <- ""

for(i in cl.names){

  year <- str_replace(i,"countdata\\.*","")
  year <- str_replace(year,"-.*csv","")
  y <- c(y,year)

}

years <- y[2:11]

years

return(print(years[3:10]))

} # end of function extract_year
# --------------------------------------
# extract_year()

years
