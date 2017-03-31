# How many users of the berlin R users Group are male/female?
# Data sources: meetup.com API, wikipedia data (first names)
library(devtools)
if("meetupr" %in% rownames(installed.packages()) == FALSE) {
        install_github("rladies/meetupr")
}

library(meetupr)
library(tidyverse)
library(jsonlite)

# see script 'first_names_from_wikipedia.R', snippet by Andreas Busjahn, modified
# https://www.meetup.com/Berlin-R-Users-Group/events/238289864/
# vectors with first-names
load("names.RData")
api_key    <- Sys.getenv("R_meetup_api_key")
group_name <- "Berlin-R-Users-Group"

events     <- get_events(group_name, api_key)
events_df  <- events %>% toJSON() %>% fromJSON()

members <-get_members(group_name, api_key)

members_df <- members %>% toJSON() %>% fromJSON()
members_df$fname <- tolower(gsub(members_df$name, pattern="\\s.*$", replacement = "", perl=TRUE))
members_df <- members_df %>%
        select(fname, status) %>%
        mutate(status = unlist(status)) %>% # remove weird artifact from JSON conversion
        mutate(is_male=fname %in% male,  # perform lookup
               is_female=fname %in% female,
               is_ambiguous = fname %in% ambiguous) %>%
        mutate(gender = ifelse(is_male==TRUE, "male",
                               ifelse(is_female==TRUE, "female",
                                      ifelse(is_ambiguous == TRUE, "ambiguous", "undetermined")))) %>%
        filter(gender %in% c("male", "female"))  # remove ambiguous or undetermined

# how many women, fraction
(tab <- prop.table(with(members_df, table(gender))))
females_fraction <- tab[[1]]

#### How many are *expected* to show up?

# generate a simulation: during the next 1000 Berlin-R-Users Group meetings, assuming
# 30 people show up each time, how many women are among them,
# when the expected fraction of women is estimated to be 22%?
n <- 30
n_trials <- 1000
females_appeared_sim <- rbinom(n = n_trials, size = n, prob = females_fraction)
hist(females_appeared_sim)

# 2.5% quantile and 97.5% quantiles
min_appear_expected <- qbinom(size=n, prob=females_fraction, p=0.025)
max_appear_expected <- qbinom(size=n, prob=females_fraction, p=0.975)

# "95% confidence interval"
round(c(min_appear_expected, max_appear_expected) / n, 2)
# => estimate: 22% of group members are women, 95% boundaries: between 7% and 37%

