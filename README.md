# @BRUG R API gender meetup

----------

Hi guys!

Here are some resources to help you along the way:

1. [prez.pdf](The link to the presentation)
2. [http://tophcito.blogspot.de/2015/11/accessing-apis-from-r-and-little-r.html](The link to the Blog post by Chritoph Walhauser)
3. [secure.meetup.com/meetup_api/key](Meetup API KEY link)
4. [https://secure.meetup.com/meetup_api/console/](Meetup api console)
5. [scrit.R](Script is here)

----------------------

Alternative way:
Use the R-Ladies package

```
install.packages("devtools")
library(devtools)
devtools::install_github("rladies/meetupr")
library(meetupr)

api_key <- "INSERT_KEY_HERE"
group_name <- "INSERT THE NAME OF THE GROUP"

members <- get_members(group_name, api_key)
```

--------------------------------------

Afterwards please post your results in this form:

https://goo.gl/forms/XaWQuBh1vQQAPQhq2
