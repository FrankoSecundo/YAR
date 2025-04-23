# --------------------------------------
# FUNCTION run_regression
# required packages: none
# description:
# inputs:
# outputs:
########################################
run_regression <- function(){


# function body

  setwd(dir = "CleanedData/")

abun <- read.csv(file = "abundance.csv",header = TRUE,sep = ",")
spec <- read.csv(file = "speciesrichness.csv",header = TRUE,sep = ",")

comb <- merge(abun,spec,by="year")

model <- lm(year_count ~ speciescount, data = comb)

model

p3 <- ggplot(comb,aes(year_count, speciescount)) +
  geom_point() +
  geom_smooth(method='lm') +theme_bw(base_size = 16)+xlab("Abundance")+ylab("Species Richness")

return(p3)

} # end of function run_regression
# --------------------------------------
# run_regression()
