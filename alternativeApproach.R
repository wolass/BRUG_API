install.packages(c("jsonlite","httr", "gender", "tm", "dat"))
devtools::install_github("rladies/meetupr")

# Packages
library(httr)
library(jsonlite)
library(dat)
library(tm)
library(gender)
library(meetupr)

# access token 
source("secret.R")


group_urlname <- "Berlin-R-Users-Group"

members <- get_members(group_urlname, token)
meetupNames <- flatmap(members, "name")

meetupNames <- meetupNames
  strsplit(" ") %>%
  flatmap(1) %>%
  removePunctuation %>%
  removeNumbers %>%
  tolower %>%
  sort

genderMeetupMembers <- gender(meetupNames)

barplot(table(genderMeetupMembers$gender))
t.test(genderMeetupMembers$gender == "female")
