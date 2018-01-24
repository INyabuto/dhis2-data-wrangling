
library(httr)
library(dplyr)
library(rjson)
#url <- "https://hiskenya.org/api/26/analytics/dataValueSet.json?dimension=dx:rc63pQlR7fm;sAWX6GB722p;u9OdDYPBIRS;UlUoAiVbs51;r5gZDfgogp0;BYkpezlbl5y;LAiLxs7oCAg;p4JRNrjpkLr;pGF8aDdlSxY;Vxbu62QgqNB;X4Toj8kLsX3;V4JsXZnGxak;KwN3jWkmjgu;Js7Ia8ffGvX&dimension=pe:LAST_12_MONTHS&dimension=ou:HfVjCurKxh2&displayProperty=NAME&skipMeta=FALSE"
url <- "https://hiskenya.org/api/26/analytics.json?dimension=dx:rc63pQlR7fm;sAWX6GB722p;u9OdDYPBIRS;UlUoAiVbs51;r5gZDfgogp0;BYkpezlbl5y;LAiLxs7oCAg;p4JRNrjpkLr;pGF8aDdlSxY;Vxbu62QgqNB;X4Toj8kLsX3;V4JsXZnGxak;KwN3jWkmjgu;Js7Ia8ffGvX&dimension=pe:LAST_12_MONTHS&dimension=ou:HfVjCurKxh2&displayProperty=NAME&skipMeta=FALSE"
url2 <- paste0("dimension=dx")
res <- GET(url,authenticate("INyabuto","Nyabuto12"))

r <- httr::content(res, "text")

d <- jsonlite::fromJSON(r, flatten = TRUE)

# Get the metadata map
metadata <- as.data.frame(sapply(d$metaData$items, "[[", "name"), stringsAsFactors = F)

names(metadata) <- "name"
metadata$uid <- row.names(metadata)


# Get the base data
data <- as.data.frame(d$rows, stringsAsFactors = F)
# Get the column names 
names(data) <- d$headers$column
# Remap the uids in the response into something readable
data$Data <- plyr::mapvalues(data$Data, metadata$uid, as.character(metadata$name), warn_missing = F)
data$ou <- plyr::mapvalues(data$`Organisation unit`, metadata$uid, as.character(metadata$name), warn_missing = F)

# Change columns types
data$Period <- as.numeric(as.character(data$Period))
data$Value <- as.numeric(as.character(data$Value))


