# --------------------------------------
# FUNCTION calculate_richness
# required packages: none
# description:
# inputs:
# outputs:
########################################
calculate_richness <- function(){

  setwd(dir = "CleanedData/")
  cmdf <- read.csv(file = "cmdf.csv",header = TRUE,sep = ",")

  cmdf.g <- cmdf %>%  group_by(scientificName,year)

  cmdf.gs <- cmdf.g %>% summarise(species_count=sum(count))

  cmdf.gs <- cmdf.gs %>% filter(scientificName != "")

  cmdf.gs$count <- 1

  cmdf.gs.g <- cmdf.gs %>% group_by(year)

  cmdf.gs.gs <- cmdf.gs.g %>% summarise(speciescount=sum(count))

  cmdf.gs.gs$year <- as.factor(cmdf.gs.gs$year)


  p2 <- ggplot(data = cmdf.gs.gs)+geom_bar(aes(x=year,y=speciescount,fill=year),stat = "identity")+ylab("Species Richness")+theme_bw(base_size = 16)

  write.csv(cmdf.gs.gs,file = "speciesrichness.csv",row.names = FALSE)




return(p2)

} # end of function calculate_richness
# --------------------------------------
# calculate_richness()
