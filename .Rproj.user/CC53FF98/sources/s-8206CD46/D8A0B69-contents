library(httr)


#' Get orgunitsgroups form dhis2
#' 
r <- GET(url = "https://192.168.0.16/dhis/api/organisationUnitGroups", 
            authenticate("admin","district"), config = config(ssl_verifypeer=FALSE))

res <- httr::content(r, "text")

d <- jsonlite::fromJSON(res, flatten = TRUE)

# extract organisationunitsgroups ids
target <- d$organisationUnitGroups$id

#' loop through the target deleting the elements

url <- "https://192.168.0.16/dhis/api/organisationUnitGroups/"

pb <- txtProgressBar(min = 0, max = length(target), style = 3)

for (i in seq_along(target)){
  response <-DELETE(url = paste0(url,target[i]),
                 authenticate("admin","district"),
                 config = config(ssl_verifypeer=FALSE))
  assertthat::assert_that(response$status == 200)
  setTxtProgressBar(pb, i)
}


