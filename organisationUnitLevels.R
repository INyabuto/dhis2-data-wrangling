library(httr)
library(dplyr)
library(jsonlite)
#' API test 
#' Setting organisatiounits levels
#' 

# Set up ==================================================================

base_url <- "https://192.168.0.16/"
username <- "admin"
password <- "district"
endpoint <- "dhis/api/metadata?importStrategy=CREATE&atomicMode=NONE"

#' create an object to post ================================================

#' read organisaion unit metadata
#setwd("./metadata")

organisationUnitLevels <- data.frame(level = c(1,2,3,4,5),
                                     name = c("National", "County", "Sub County", "Ward","Health Centers"))



pb <- txtProgressBar(min = 0, max = nrow(organisationUnitLevels), style = 3)

for (i in seq_along(1:nrow(orgunits_target))){
  r <- POST(url = paste0(base_url,endpoint), 
            authenticate(username, password),
            body = list(organisationUnitLevels = organisationUnitLevels[i,]),
            encode = "json",
            config = config(ssl_verifypeer = FALSE))
  assertthat::assert_that(r$status == 200)
  setTxtProgressBar(pb, i)
}





