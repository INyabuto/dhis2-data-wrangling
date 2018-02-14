library(RCurl)

dest.user <- "admin"
dest.pass <- "district"
source.user <- "INyabuto"
source.pass <- "Nyabuto12"
dest.url <- "https://192.168.0.16/dhis/api/"
source.url <- "https://hiskenya.org/api/"
property.url <- ".json?paging=false&links=false"

# a function to verify the ids were mapped correctly.

isLength11 <- function(x){
  if (nchar(x)==11) return(TRUE)
  else return(FALSE)
}

isLength11 = Vectorize(isLength11)
dv <- list(dataValues=deliveries.giz)
cat(file = "deliveries.json", jsonlite::toJSON(dv, auto_unbox = TRUE))

# test the file import to see
url <- paste0(dest.url, "dataValueSets?dryRun=true&preheatCache=false")
h <- basicTextGatherer()
RCurl::getURL(url = url,
                   userpwd = paste0(dest.user,":",dest.pass),
                   httpauth = 1L,
                   httpheader = c(Accept = "application/json",
                                  Accept = "multipart/*",
                                  'Content-Type'="application/json"),
                   postfields = jsonlite::toJSON(dv,auto_unbox = TRUE),
                   verbose = FALSE,
                   writefunction = h$update,
                   ssl.verifypeer = FALSE)

