library(httr)
library(dplyr)

# setting work space
username <- "admin"
password <- "district"

url <- "https://test.gizhsp.org/dhis/api/27/dataElements/tQUr3gaxEDf.json"

# Get the data element

res <- GET(url, authenticate(username, password), config = httr::config(ssl_verifypeer=FALSE))

# Parse the response as text
r <- httr::content(res, "text")

# Conevert the json object into an R object

d <- jsonlite::fromJSON(r, flatten = TRUE)

# Map out the metadata
dataelement <- as.data.frame(d$id)



# load the maternal deaths 20 + years
maternal_deaths <- read.csv(file = "Maternal deaths 20 + years.csv", stringsAsFactors = F)

# tranform the maternal deaths name to what is our dhis2
maternal_deaths$Data <- dataelement$`d$id`

names(maternal_deaths) <- c("dataElement","period","orgunit","value")


write.table(maternal_deaths, file = "maternal deaths.csv", row.names = F, sep = ",")


# Post the data into the dhis2
base_url <- "https://test.gizhsp.org/dhis/api/dataValueSets"

pb <- txtProgressBar(min = 1, max = nrow(maternal_deaths), style = 3)

for (i in seq_along(1:nrow(maternal_deaths))) {
  x <- POST(base_url, config = config(ssl_verifypeer = FALSE), 
           body = list(dataValues = list(dataElement = maternal_deaths$dataElement[i],
                                       period = maternal_deaths$period[i],
                                       orgUnit = maternal_deaths$orgunit[i],
                                       value = maternal_deaths$value[i])),
                           authenticate("INyambuka", "Nyambuka@12"),
                           verbose = TRUE,
                           encode = "json")
  #assertthat::assert_that(x$status == 204L)
  setTxtProgressBar(pb, i)
}
close(pb)


