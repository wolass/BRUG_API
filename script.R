install.packages(c("jsonlite","httr"))
library(httr)
library(jsonlite)
# options(stringsAsFactors = FALSE)

url  <- "https://api.meetup.com"

group_urlname <- "Berlin-R-Users-Group"
source("secret.R")
method <- "/2/members"

path <- paste0(method,
               "?key=",
               token,
               "&sign=true",
               "&group_urlname=",
               group_urlname)


raw.result <- GET(url = url, path = path)

names(raw.result)

raw.result$status_code

head(raw.result$content)

this.raw.content <- rawToChar(raw.result$content)

this.content <- fromJSON(this.raw.content)

this.content$results$country

this.content$results$name

### The alternative (easy) way!
devtools::install_github("rladies/meetupr")
library(meetupr)

members <- get_members(group_urlname, token)
