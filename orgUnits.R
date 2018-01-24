library(dplyr)
setwd("./metadata")
#'
#'Read the orgunits_list
orgunits_list <- read.csv(file="orgunits_list_kqmh.csv", stringsAsFactors = FALSE)


# Filter Kenya
Kenya <- filter(orgunits_list, name == "Kenya")
# Get the all the counties 
counties <- filter(orgunits_list, parent == Kenya[,2])

# the five counties of focus 
focus_counties <- filter(counties, name %in% c("Kisumu County", "Vihiga County", "Siaya County", "Kisumu County", "Kwale County"))

# Get the sub counties
sub_counties <- filter(orgunits_list, parent %in% focus_counties[,2])

# Get the wards
wards <- filter(orgunits_list, parent %in% sub_counties[,2])

# Get the community clinics
community <- filter(orgunits_list, parent %in% wards[,2])
# Get the lowest
community_units <- filter(orgunits_list, parent %in% community[,2])

#' merge into Kenya and focus counties
Kenya_focus_counties <- rbind(Kenya, focus_counties)

# Merge the rows into one dataframe 
orgunits_giz <- rbind(Kenya,focus_counties,sub_counties, wards, community, community_units)

write.table(orgunits_giz, file = "orgunits_list_giz.csv", sep = ",", row.names = FALSE)

write.table(Kenya_focus_counties, file = "Kenya_focus_counties.csv", sep = ",", row.names = FALSE)
