#'
#'An api to access dhis2 data elements
#'

# Set up ====================
require(RCurl)
require(httr)
require(plyr)

pass <- "INyabuto:Nyabuto12"
username <- "INyabuto"
password <- "Nyabuto12"
url1 <- "https://hiskenya.org/api/"
url3 <- ".json?paging=false&links=false"


# Get metadata ====================

url <- paste0(url1,"dataElements",url3)
response <- getURL(url,
                   userpwd =pass,
                   httpauth = 1L,
                   header = FALSE,
                   ssl.verifypeer = FALSE)
parse_res <- jsonlite::fromJSON(response, simplifyVector = F)
# Parse out names and ids
name <- sapply(parse_res[["dataElements"]], "[[", "displayName")
id <- sapply(parse_res[["dataElements"]], "[[", "id")

# Bind
temp <- cbind(name, id)
# recast as a data frame
dataElements <- as.data.frame(temp,
                    stringsAsFactors=FALSE,
                    row.names=NULL)

# write the datelemtns into a csv file
write.table(dataElements, file = "dataElements.csv", quote = TRUE, sep = ",", row.names = FALSE)






