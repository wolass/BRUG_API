#### README.md
#### Results from Team "Middle of the road" 

This R code might not be 100% identical with what we did during the meetup.
I didn't write much code during the meetup, so I tried to reproduce our thought process.


Most of this code in file 'meetup-gender.R' was the work of my teammembers Andrew (who came up with the `dplyr` pipe, and the `dbinom()` call),
and Andreas Busjahn, who wrote the script to fetch/parse the first-names data from Wikipedia. This is saved in `names.RData`.

For the script, see his comment in https://www.meetup.com/Berlin-R-Users-Group/events/238289864/ or my modification, file `first_names_from_wikipedia.R`

Our estimate was: There are 22% women in the group, but it might be as well between 7% and 37%. 
This is not a true confidence interval, but rather quantiles at the 2.5% and 97.5% level for a particular binomial distribution.

Best regards, 

Knut Behrends
