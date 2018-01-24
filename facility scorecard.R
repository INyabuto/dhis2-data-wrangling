library(httr)
library(dplyr)

username <- "INyabuto"
password <- "Nyabuto12"

url <- "https://hiskenya.org/api/26/analytics.json?dimension=dx:eBHhfupqMHz&dimension=pe:201701;201702;201703;201704;201705;201706;201707;201708;201709;201710;201711;201712;201601;201602;201603;201604;201605;201606;201607;201608;201609;201610;201611;201612;LAST_12_MONTHS&dimension=ou:HfVjCurKxh2&displayProperty=NAME&skipMeta=FALSE"

response <- GET(url, authenticate(username, password))

# parse the content as text
r <- httr::content(response, "text")

d <- jsonlite::fromJSON(r, flatten = TRUE)

# Get the metadata map
metadata <- as.data.frame(sapply(d$metaData$items, "[[", "name"), stringsAsFactors = FALSE)
names(metadata) <- "name"
metadata$uid <- row.names(metadata)


# Get the base data
data <- as.data.frame(d$rows, stringsAsFactors = FALSE)

# Get the column names for the data as is in the response
names(data) <- d$headers$column

# remap the uids in the response into something readable
data$Data <- plyr::mapvalues(data$Data, metadata$uid, as.character(metadata$name), warn_missing = F)
#data$'Organisation unit' <- plyr::mapvalues(data$`Organisation unit`, metadata$uid, as.character(metadata$name), warn_missing = F)

# Change the column types
data$Period <- as.numeric(data$Period)
data$Value <- as.numeric(data$Value)


# write the data frame to a csv file
write.table(data, file = "Maternal deaths 20 + years.csv", quote = TRUE, sep = ",", row.names = F)

