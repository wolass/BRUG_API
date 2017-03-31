library(rvest)
library(stringr)
male <- female <- ambiguous <- character()
for (link_i in LETTERS) {
        url <-paste0('https://de.wikipedia.org/wiki/Liste_von_Vornamen/',
              link_i)
        outfile <- sprintf("%s_temp.html", link_i)
        if(! file.exists(outfile)){
                download.file(url, destfile = outfile)
        }
        htmlsource <- read_html(outfile)
        htmlnodes <- html_nodes(htmlsource, 'p')
        names<-html_text(htmlnodes)
        names<-names[grep('[♂♀]',names)[-1] ]

        names<-lapply(names,FUN=strsplit,split=',')
        names<-str_trim(unlist(names))
        # male<-c(male,names[grep('\\s♂$',names)])
        # female<-c(female,names[grep('\\s♀$',names)])
        # ambiguous<-c(ambiguous,names[grep('\\s♂♀$',names)])
        names <- names[grepl('♂$|♀$', names)]
        #male<-c(male,names[grepl('\\s♂$',names)])
        male<-c(male,names[grep('♂\\Z',names, perl=TRUE)])
        female<-c(female,names[grep('(?<!♂)♀',names, perl=TRUE)])
        ambiguous<-c(ambiguous,names[grep('♂♀',names)])
}

male   <- tolower(str_trim(gsub("\\s*♂\\s*", '', male, perl=TRUE)))
female <- tolower(str_trim(gsub("\\s*♀\\s*", '', female)))
ambiguous <- tolower(str_trim(gsub('\\s*♂♀\\s*', '', ambiguous)))
save(male, female, ambiguous, file = 'names.RData')
rm(list = ls())
load("names.RData")

