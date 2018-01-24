
library(httr)
library(dplyr)

#'
#'
#'
#' Testing with play demo

url2 <- "https://play.dhis2.org/demo/api/26/analytics.json?dimension=dx:eY5ehpbEsB7&dimension=pe:201601;201602;201603;201604;201605;201606;201607;201608;201609;201610;201611;201612;LAST_12_MONTHS&filter=ou:ImspTQPwCqd&displayProperty=NAME"
response <- GET(url2, authenticate("admin","district"))

# Parse the response as string
parse_res <- httr::content(response, "text")

# Convert to R objetc
res <- jsonlite::fromJSON(parse_res, flatten = TRUE)

# Meta data map
metadata2 <- as.data.frame(sapply(res$metaData$items, "[[", "name"))

names(metadata2) <- "name"

metadata2$uid <- row.names(metadata2)

# Get the values
data <- as.data.frame(res$rows, stringsAsFactors = F)

# Get column names from the header
names(data) <- res$headers$column


# Get the same dat for BO, Bombali and BO

url <- "https://play.dhis2.org/demo/api/26/analytics.json?dimension=dx:eY5ehpbEsB7&dimension=pe:201601;201602;201603;201604;201605;201606;201607;201608;201609;201610;201611;201612;LAST_12_MONTHS&dimension=ou:O6uvpzGd5pu;fdc6uOvgoji;lc3eMKXaEfw&displayProperty=NAME"

r <- GET(url, authenticate("admin","district"))

r <- httr::content(r, "text")

d <- jsonlite::fromJSON(r, flatten = TRUE)

metadata <- as.data.frame(sapply(d$metaData$items, "[[", "name"), stringsAsFactors = F)

names(metadata) <- "name"

metadata$uid <- row.names(metadata)



# Get data
test <- as.data.frame(d$rows, stringsAsFactors = F)

names(test) <- d$headers$column

test_code <- test

test$Data <- plyr::mapvalues(test$Data, from = metadata$uid, to = as.character(metadata$name), warn_missing = F)
test$`Organisation unit` <- plyr::mapvalues(test$`Organisation unit`,from = metadata$uid, to = as.character(metadata$name), warn_missing = F)


#'
#'Get the data of the counties to be for sieraleone

test_code$Value <- as.numeric(test_code$Value)*100

cholera <- test_code

pb <- txtProgressBar(min = 1, max = nrow(cholera))

for (i in seq_along(1:nrow(cholera))){
  url3 <- "https://play.dhis2.org/demo/api/dataValueSets"
  r <- POST(url3,
            body = list(dataElement = cholera$Data[i],
                        period = cholera$Period[i],
                        orgUnit = cholera$`Organisation unit`[i],
                        value = cholera$Value[i]),
            encode = "json")
  #assertthat::assert_that(r$status == 204L)
  setTxtProgressBar(pb, i)
  
}

write.table(cholera, file = "cholera.csv", sep = ",", row.names = F)

