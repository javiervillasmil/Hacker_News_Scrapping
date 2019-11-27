#import libraries
if(require("pacman")=="FALSE"){
  install.packages('pacman')
  library('pacman')
  pacman::p_load(here,rvest,crayon,openxlsx,stringr,lubridate,doParallel) # <- add libraries here
} else {
  library('pacman')
  pacman::p_load(here,rvest,crayon,openxlsx,stringr,lubridate,doParallel) # <- add libraries here
}

#checks loaded libraries
p_loaded()

#load scrapping functions
for (h in list.files(here::here('scripts'))){
  source(here::here('scripts',h))
}

#enables paralell processing
do_parallel_function()

#initialize vectors
title <- c()
point <- c()
link <- c()
comment <- c()
all_urls <- c()

#scrap the webpages
j = 2
for (i in seq(1, j, by=1)) {
url <- paste('https://news.ycombinator.com/show?p=',i,sep="") #change the website here
webpage <- read_html(url)
title <- c(title,title_scrap(webpage))
point <- c(point,point_scrap(webpage))
comment <- c(comment,comment_scrap(webpage))
link <- c(link,link_scrap(webpage))
all_urls <- c(all_urls,url)
}

#generates  dataframe
hackernews_df <- generate_hackernews_df()
